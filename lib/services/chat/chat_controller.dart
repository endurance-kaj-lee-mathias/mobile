import 'dart:async';

import 'package:endurance_mobile_app/services/auth/auth_controller.dart';
import 'package:endurance_mobile_app/services/chat/chat_models.dart';
import 'package:endurance_mobile_app/services/chat/chat_service.dart';
import 'package:endurance_mobile_app/services/chat/websocket_service.dart';
import 'package:endurance_mobile_app/services/network/member_model.dart';
import 'package:endurance_mobile_app/services/network/network_controller.dart';
import 'package:endurance_mobile_app/services/user/user_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  ChatController({ChatService? service, WebSocketService? wsService})
      : _chatService = service ?? ChatService(),
        _wsService = wsService ?? Get.find<WebSocketService>();

  final ChatService _chatService;
  final WebSocketService _wsService;

  final RxList<ConversationModel> conversations = <ConversationModel>[].obs;
  final RxBool isLoading = false.obs;

  // conversationId → reactive message list
  final Map<String, RxList<MessageModel>> _messagesCache = {};
  // otherUserId → ConversationModel (to avoid re-fetching on nav)
  final Map<String, ConversationModel> _conversationByUserId = {};

  StreamSubscription<WsOutboundMessage>? _wsSub;

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  @override
  void onInit() {
    super.onInit();

    final auth = Get.find<AuthController>();
    final network = Get.find<NetworkController>();
    final userCtrl = Get.find<UserController>();

    ever(auth.isAuthenticated, (bool isAuth) {
      if (isAuth) {
        _wsService.connect();
        _setupWsListener();
        // Wait for user to load before we can determine "other" participant.
        if (userCtrl.user.value != null) {
          _loadConversations(network.members);
        }
      } else {
        _wsService.disconnect();
        _wsSub?.cancel();
        conversations.clear();
        _messagesCache.clear();
        _conversationByUserId.clear();
      }
    });

    // Trigger load once the current user profile arrives.
    ever(userCtrl.user, (user) {
      if (user != null && auth.isAuthenticated.value) {
        _loadConversations(network.members);
      }
    });

    // Reload when the member list changes (new connections accepted, etc.)
    ever(network.members, (List<MemberModel> _) {
      if (auth.isAuthenticated.value && userCtrl.user.value != null) {
        _loadConversations(network.members);
      }
    });

    if (auth.isAuthenticated.value) {
      _wsService.connect();
      _setupWsListener();
      if (userCtrl.user.value != null) {
        _loadConversations(network.members);
      }
    }
  }

  @override
  void onClose() {
    _wsSub?.cancel();
    super.onClose();
  }

  // ── Public API ─────────────────────────────────────────────────────────────

  /// Returns the reactive message list for [conversationId], creating it on
  /// first access. Call [loadMessages] to populate it.
  RxList<MessageModel> messagesFor(String conversationId) =>
      _messagesCache.putIfAbsent(conversationId, () => <MessageModel>[].obs);

  /// Loads messages for [conversationId] from the API unless already cached.
  /// Set [refresh] to true to force a reload.
  Future<void> loadMessages(
    String conversationId, {
    bool refresh = false,
    int limit = 50,
  }) async {
    final cache = _messagesCache[conversationId];
    if (cache != null && cache.isNotEmpty && !refresh) return;

    try {
      final msgs = await _chatService.getMessages(
        conversationId,
        limit: limit,
      );
      msgs.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      messagesFor(conversationId).assignAll(msgs);

      if (msgs.isNotEmpty) {
        _updateLastMessage(conversationId, msgs.last);
      }
    } catch (e) {
      debugPrint('ChatController.loadMessages error: $e');
    }
  }

  /// Load more (older) messages for pagination.
  Future<void> loadMoreMessages(String conversationId) async {
    final existing = messagesFor(conversationId);
    try {
      final older = await _chatService.getMessages(
        conversationId,
        limit: 30,
        offset: existing.length,
      );
      if (older.isEmpty) return;
      older.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      existing.insertAll(0, older);
    } catch (e) {
      debugPrint('ChatController.loadMoreMessages error: $e');
    }
  }

  /// Sends [content] to [conversationId]. Persists via REST then broadcasts
  /// via WebSocket so the other participant receives it in real time.
  Future<bool> sendMessage(String conversationId, String content) async {
    try {
      final message = await _chatService.sendMessage(conversationId, content);

      // Add to local cache immediately (optimistic UI).
      final cache = messagesFor(conversationId);
      if (cache.every((m) => m.id != message.id)) {
        cache.add(message);
      }
      _updateLastMessage(conversationId, message);

      // Broadcast via WebSocket so the other participant receives it live.
      _wsService.sendMessage(
        'conversation:$conversationId',
        message.toJson(),
      );

      return true;
    } catch (e) {
      debugPrint('ChatController.sendMessage error: $e');
      return false;
    }
  }

  /// Creates or retrieves the conversation with [member]. Returns the
  /// [ConversationModel] so the caller can navigate to the detail page.
  Future<ConversationModel?> startConversationWith(MemberModel member) async {
    final userId = member.id;
    if (_conversationByUserId.containsKey(userId)) {
      return _conversationByUserId[userId];
    }

    try {
      final conv = await _chatService.startConversation(userId);
      _enrichFromMember(conv, member);
      _conversationByUserId[userId] = conv;

      if (conversations.every((c) => c.id != conv.id)) {
        conversations.add(conv);
        _sortConversationsInPlace();
      }

      _wsService.subscribe('conversation:${conv.id}');
      return conv;
    } catch (e) {
      debugPrint('ChatController.startConversationWith error: $e');
      return null;
    }
  }

  // ── Internal ───────────────────────────────────────────────────────────────

  Future<void> _loadConversations(List<MemberModel> members) async {
    final myId = Get.find<UserController>().user.value?.id ?? '';
    if (myId.isEmpty) return; // User not loaded yet — wait for `ever(userCtrl.user, ...)`.

    isLoading.value = conversations.isEmpty;

    // Build a lookup map for quick member enrichment by their user UUID.
    final memberByUserId = {for (final m in members) m.id: m};

    try {
      final convList = await _chatService.getConversations();

      final futures = convList.map((conv) async {
        // Determine the other participant's UUID.
        final otherId = conv.participants.firstWhere(
          (p) => p != myId,
          orElse: () => conv.participants.isNotEmpty ? conv.participants.first : '',
        );

        conv.otherUserId = otherId;

        // Enrich with known member data or fetch from API.
        final knownMember = memberByUserId[otherId];
        if (knownMember != null) {
          _enrichFromMember(conv, knownMember);
        } else if (otherId.isNotEmpty) {
          await _enrichFromApi(conv, otherId);
        }

        _conversationByUserId[otherId] = conv;

        // Load the latest message for the preview.
        if (conv.lastMessage == null) {
          try {
            final msgs = await _chatService.getMessages(conv.id, limit: 1);
            if (msgs.isNotEmpty) conv.lastMessage = msgs.first;
          } catch (_) {}
        }

        _wsService.subscribe('conversation:${conv.id}');
        return conv;
      });

      final loaded = (await Future.wait(futures)).toList();
      _sortConversations(loaded);
      conversations.assignAll(loaded);
    } catch (e) {
      debugPrint('ChatController._loadConversations error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _enrichFromMember(ConversationModel conv, MemberModel member) {
    conv.otherUserId = member.id;
    conv.otherUserFirstName = member.firstName;
    conv.otherUserLastName = member.lastName;
    conv.otherUserImage = member.image;
  }

  Future<void> _enrichFromApi(ConversationModel conv, String userId) async {
    try {
      final userInfo = await _chatService.getUser(userId);
      conv.otherUserFirstName = userInfo['firstName']?.toString();
      conv.otherUserLastName = userInfo['lastName']?.toString();
      conv.otherUserImage = userInfo['image']?.toString();
    } catch (e) {
      debugPrint('ChatController._enrichFromApi error for $userId: $e');
    }
  }

  void _setupWsListener() {
    _wsSub?.cancel();
    _wsSub = _wsService.incoming.listen(_handleWsMessage);
  }

  void _handleWsMessage(WsOutboundMessage wsMsg) {
    if (!wsMsg.channel.startsWith('conversation:')) return;
    final convId = wsMsg.channel.replaceFirst('conversation:', '');

    final payload = wsMsg.payload;
    if (payload is! Map<String, dynamic>) return;

    try {
      final message = MessageModel.fromJson(payload);

      // De-duplicate: skip if already added (e.g. own message after REST save).
      final cache = messagesFor(convId);
      if (cache.any((m) => m.id == message.id)) return;

      cache.add(message);
      _updateLastMessage(convId, message);
    } catch (e) {
      debugPrint('ChatController._handleWsMessage error: $e');
    }
  }

  void _updateLastMessage(String conversationId, MessageModel message) {
    final idx = conversations.indexWhere((c) => c.id == conversationId);
    if (idx == -1) return;

    final conv = conversations[idx];
    if (conv.lastMessage == null ||
        message.createdAt.isAfter(conv.lastMessage!.createdAt)) {
      conv.lastMessage = message;
      conversations.refresh();
      final sorted = List<ConversationModel>.from(conversations);
      _sortConversations(sorted);
      conversations.assignAll(sorted);
    }
  }

  void _sortConversations(List<ConversationModel> list) {
    list.sort((a, b) {
      if (a.lastMessage == null && b.lastMessage == null) return 0;
      if (a.lastMessage == null) return 1;
      if (b.lastMessage == null) return -1;
      return b.lastMessage!.createdAt.compareTo(a.lastMessage!.createdAt);
    });
  }

  void _sortConversationsInPlace() {
    final sorted = List<ConversationModel>.from(conversations);
    _sortConversations(sorted);
    conversations.assignAll(sorted);
  }
}
