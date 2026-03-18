import 'dart:async';
import 'dart:convert';

import 'package:endurance_mobile_app/core/app_config.dart';
import 'package:endurance_mobile_app/services/auth/auth_controller.dart';
import 'package:endurance_mobile_app/services/chat/chat_models.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService extends GetxService {
  final Map<String, WebSocketChannel> _channels = {};
  final Map<String, StreamSubscription<dynamic>> _subs = {};
  final Map<String, Timer> _reconnectTimers = {};
  final Map<String, int> _reconnectAttempts = {};

  final Set<String> _managedConversations = {};

  final _incomingController =
      StreamController<WsOutboundMessage>.broadcast();

  bool _intentionallyClosed = false;

  Stream<WsOutboundMessage> get incoming => _incomingController.stream;

  String get _wsBaseUrl => AppConfig.apiBaseUrl
      .replaceFirst('https://', 'wss://')
      .replaceFirst('http://', 'ws://');

  void connect() {
    _intentionallyClosed = false;
  }

  void subscribe(String channel) {
    if (!channel.startsWith('conversation:')) return;
    final convId = channel.replaceFirst('conversation:', '');
    _managedConversations.add(convId);
    if (!_channels.containsKey(convId)) {
      _connectConversation(convId);
    }
  }

  void unsubscribe(String channel) {
    if (!channel.startsWith('conversation:')) return;
    final convId = channel.replaceFirst('conversation:', '');
    _managedConversations.remove(convId);
    _closeConversation(convId);
  }

  void disconnect() {
    _intentionallyClosed = true;
    for (final convId in List<String>.from(_managedConversations)) {
      _closeConversation(convId);
    }
    _managedConversations.clear();
  }

  Future<void> _connectConversation(String convId) async {
    if (_intentionallyClosed) return;

    final auth = Get.find<AuthController>();
    final token = auth.token.value?.accessToken;
    if (token == null) return;

    final uri = Uri.parse('$_wsBaseUrl/ws/$convId');

    try {
      await _subs[convId]?.cancel();
      await _channels[convId]?.sink.close();
      _subs.remove(convId);
      _channels.remove(convId);

      final channel = IOWebSocketChannel.connect(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );

      await channel.ready;

      _channels[convId] = channel;
      _reconnectAttempts[convId] = 0;

      _subs[convId] = channel.stream.listen(
        (data) => _onMessage(convId, data),
        onError: (error) => _onError(convId, error),
        onDone: () => _onDone(convId),
        cancelOnError: false,
      );
    } catch (e) {
      debugPrint('WebSocket[$convId] connect error: $e');
      _scheduleReconnect(convId);
    }
  }

  void _closeConversation(String convId) {
    _reconnectTimers[convId]?.cancel();
    _reconnectTimers.remove(convId);
    _reconnectAttempts.remove(convId);
    _subs[convId]?.cancel();
    _subs.remove(convId);
    _channels[convId]?.sink.close();
    _channels.remove(convId);
  }

  void _onMessage(String convId, dynamic data) {
    try {
      final json = jsonDecode(data as String) as Map<String, dynamic>;
      json['channel'] = 'conversation:$convId';
      if (!_incomingController.isClosed) {
        _incomingController.add(WsOutboundMessage.fromJson(json));
      }
    } catch (e) {
      debugPrint('WebSocket[$convId] message parse error: $e');
    }
  }

  void _onError(String convId, dynamic error) {
    debugPrint('WebSocket[$convId] error: $error');
    _channels.remove(convId);
    _subs.remove(convId);
    _scheduleReconnect(convId);
  }

  void _onDone(String convId) {
    debugPrint('WebSocket[$convId] connection closed');
    _channels.remove(convId);
    _subs.remove(convId);
    _scheduleReconnect(convId);
  }

  void _scheduleReconnect(String convId) {
    if (_intentionallyClosed) return;
    if (!_managedConversations.contains(convId)) return;
    _reconnectTimers[convId]?.cancel();
    final attempts = _reconnectAttempts[convId] ?? 0;
    final delay = Duration(seconds: attempts < 5 ? (1 << attempts) : 30);
    _reconnectAttempts[convId] = attempts + 1;
    _reconnectTimers[convId] = Timer(delay, () => _connectConversation(convId));
  }

  @override
  void onClose() {
    disconnect();
    _incomingController.close();
    super.onClose();
  }
}
