import 'dart:async';
import 'dart:convert';

import 'package:endurance_mobile_app/config/app_config.dart';
import 'package:endurance_mobile_app/services/auth/auth_controller.dart';
import 'package:endurance_mobile_app/services/chat/chat_models.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService extends GetxService {
  WebSocketChannel? _channel;
  StreamSubscription<dynamic>? _subscription;

  final _incomingController =
      StreamController<WsOutboundMessage>.broadcast();

  final RxBool isConnected = false.obs;

  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;
  bool _intentionallyClosed = false;

  /// Channels the client is currently subscribed to. Replayed on reconnect.
  final Set<String> _subscribedChannels = {};

  Stream<WsOutboundMessage> get incoming => _incomingController.stream;

  String get _wsBaseUrl => AppConfig.apiBaseUrl
      .replaceFirst('https://', 'wss://')
      .replaceFirst('http://', 'ws://');

  void connect() {
    _intentionallyClosed = false;
    _reconnectAttempts = 0;
    _doConnect();
  }

  void subscribe(String channel) {
    _subscribedChannels.add(channel);
    _sendRaw({'type': 'subscribe', 'channel': channel});
  }

  void unsubscribe(String channel) {
    _subscribedChannels.remove(channel);
    _sendRaw({'type': 'unsubscribe', 'channel': channel});
  }

  void sendMessage(String channel, Map<String, dynamic> payload) {
    _sendRaw({'type': 'message', 'channel': channel, 'payload': payload});
  }

  void disconnect() {
    _intentionallyClosed = true;
    _reconnectTimer?.cancel();
    _subscription?.cancel();
    _channel?.sink.close();
    isConnected.value = false;
    _subscribedChannels.clear();
  }

  Future<void> _doConnect() async {
    if (_intentionallyClosed) return;

    final auth = Get.find<AuthController>();
    final token = auth.token.value?.accessToken;
    if (token == null) return;

    final uri = Uri.parse('$_wsBaseUrl/ws');

    try {
      _subscription?.cancel();
      _channel?.sink.close();

      _channel = IOWebSocketChannel.connect(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );

      // In web_socket_channel v3, the connection handshake is asynchronous.
      // Awaiting `ready` ensures the connection is established before we
      // proceed — and surfaces any connection errors so they can be caught
      // here rather than becoming unhandled exceptions.
      await _channel!.ready;

      isConnected.value = true;
      _reconnectAttempts = 0;

      _subscription = _channel!.stream.listen(
        _onMessage,
        onError: _onError,
        onDone: _onDone,
        cancelOnError: false,
      );

      // Re-subscribe to all tracked channels after (re)connect.
      for (final ch in _subscribedChannels) {
        _sendRaw({'type': 'subscribe', 'channel': ch});
      }
    } catch (e) {
      debugPrint('WebSocket connect error: $e');
      _scheduleReconnect();
    }
  }

  void _onMessage(dynamic data) {
    try {
      final json = jsonDecode(data as String) as Map<String, dynamic>;
      if (!_incomingController.isClosed) {
        _incomingController.add(WsOutboundMessage.fromJson(json));
      }
    } catch (e) {
      debugPrint('WebSocket message parse error: $e');
    }
  }

  void _onError(dynamic error) {
    debugPrint('WebSocket error: $error');
    isConnected.value = false;
    _scheduleReconnect();
  }

  void _onDone() {
    debugPrint('WebSocket connection closed');
    isConnected.value = false;
    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    if (_intentionallyClosed) return;
    _reconnectTimer?.cancel();
    // Exponential back-off: 1 s, 2 s, 4 s, 8 s, 16 s … capped at 30 s.
    final delay = Duration(
      seconds: _reconnectAttempts < 5 ? (1 << _reconnectAttempts) : 30,
    );
    _reconnectAttempts++;
    _reconnectTimer = Timer(delay, () => _doConnect());
  }

  void _sendRaw(Map<String, dynamic> data) {
    if (_channel == null || !isConnected.value) return;
    try {
      _channel!.sink.add(jsonEncode(data));
    } catch (e) {
      debugPrint('WebSocket send error: $e');
    }
  }

  @override
  void onClose() {
    disconnect();
    _incomingController.close();
    super.onClose();
  }
}
