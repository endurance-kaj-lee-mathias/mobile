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

  final Map<String, RxList<MessageModel>> _messagesCache = {};
  final Map<String, ConversationModel> _conversationByUserId = {};

  StreamSubscription<WsOutboundMessage>? _wsSub;
  bool _loadingConversations = false;
  String? activeConversationId;
  int get totalUnreadCount =>
      conversations.fold(0, (sum, c) => sum + c.unreadCount);

  void markAsRead(String conversationId) {
    final idx = conversations.indexWhere((c) => c.id == conversationId);
    if (idx == -1) return;
    final conv = conversations[idx];
    if (conv.unreadCount == 0) return;
    conv.unreadCount = 0;
    conv.firstUnreadAt = null;
    conversations.refresh();
  }

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
        if (userCtrl.user.value != null) {
          _loadConversations();
        }
      } else {
        _wsService.disconnect();
        _wsSub?.cancel();
        conversations.clear();
        _messagesCache.clear();
        _conversationByUserId.clear();
      }
    });

    ever(userCtrl.user, (user) {
      if (user != null && auth.isAuthenticated.value) {
        _loadConversations();
      }
    });

    ever(network.members, (List<MemberModel> _) {
      if (auth.isAuthenticated.value && userCtrl.user.value != null) {
        _loadConversations();
      }
    });

    if (auth.isAuthenticated.value) {
      _wsService.connect();
      _setupWsListener();
      if (userCtrl.user.value != null) {
        _loadConversations();
      }
    }
  }

  @override
  void onClose() {
    _wsSub?.cancel();
    super.onClose();
  }

  RxList<MessageModel> messagesFor(String conversationId) =>
      _messagesCache.putIfAbsent(conversationId, () => <MessageModel>[].obs);

  Future<void> loadMessages(
    String conversationId, {
    bool refresh = false,
    int limit = 50,
  }) async {
    final cache = _messagesCache[conversationId];
    if (cache != null && cache.isNotEmpty && cache.any((m) => m.id.isNotEmpty) && !refresh) return;

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

  Future<bool> sendMessage(String conversationId, String content) async {
    try {
      final message = await _chatService.sendMessage(conversationId, content);

      final cache = messagesFor(conversationId);
      final alreadyExists = cache.any((m) =>
          m.id == message.id ||
          (m.senderId == message.senderId &&
              m.content == message.content &&
              m.createdAt.difference(message.createdAt).abs() <=
                  const Duration(seconds: 2)));
      if (!alreadyExists) {
        cache.add(message);
      }
      _updateLastMessage(conversationId, message);

      return true;
    } catch (e) {
      debugPrint('ChatController.sendMessage error: $e');
      return false;
    }
  }

  Future<void> refreshConversations() => _loadConversations();

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

  Future<void> _loadConversations() async {
    if (_loadingConversations) return;
    _loadingConversations = true;

    isLoading.value = conversations.isEmpty;

    try {
      final convList = await _chatService.getConversations();

      final currentUserId =
          Get.find<UserController>().user.value?.id ?? '';
      final network = Get.find<NetworkController>();

      for (final conv in convList) {
        if (conv.otherUserId == null && conv.participants.isNotEmpty) {
          final otherId = conv.participants
              .firstWhereOrNull((p) => p != currentUserId);
          if (otherId != null) {
            final member = network.members.firstWhereOrNull(
              (m) => m.id == otherId || m.veteran == otherId,
            );
            if (member != null) {
              _enrichFromMember(conv, member);
            } else {
              conv.otherUserId = otherId;
            }
          }
        }

        final existing = conversations.firstWhereOrNull((c) => c.id == conv.id);
        if (existing != null) {
          conv.unreadCount = existing.unreadCount;
          conv.firstUnreadAt = existing.firstUnreadAt;
          if (existing.lastMessage != null &&
              (conv.lastMessage == null ||
                  existing.lastMessage!.createdAt
                      .isAfter(conv.lastMessage!.createdAt))) {
            conv.lastMessage = existing.lastMessage;
          }
        }

        if (conv.otherUserId != null) {
          _conversationByUserId[conv.otherUserId!] = conv;
        }

        _wsService.subscribe('conversation:${conv.id}');
      }

      _sortConversations(convList);
      conversations.assignAll(convList);

      _prefetchMissingLastMessages(convList);
    } catch (e) {
      debugPrint('ChatController._loadConversations error: $e');
    } finally {
      isLoading.value = false;
      _loadingConversations = false;
    }
  }

  void _prefetchMissingLastMessages(List<ConversationModel> convList) {
    for (final conv in convList) {
      if (conv.lastMessage != null) continue;
      loadMessages(conv.id).catchError((_) {});
    }
  }

  void _enrichFromMember(ConversationModel conv, MemberModel member) {
    conv.otherUserId = member.id;
    conv.otherUserFirstName = member.firstName;
    conv.otherUserLastName = member.lastName;
    conv.otherUserImage = member.image;
  }

  void _setupWsListener() {
    _wsSub?.cancel();
    _wsSub = _wsService.incoming.listen(_handleWsMessage);
  }

  void _handleWsMessage(WsOutboundMessage wsMsg) {
    if (!wsMsg.channel.startsWith('conversation:')) return;
    final convId = wsMsg.channel.replaceFirst('conversation:', '');

    try {
      final message = MessageModel(
        id: '',
        conversationId: convId,
        senderId: wsMsg.senderId,
        content: wsMsg.content,
        createdAt: wsMsg.createdAt,
      );

      final cache = messagesFor(convId);
      if (cache.any((m) =>
          m.senderId == message.senderId &&
          m.content == message.content &&
          m.createdAt.difference(message.createdAt).abs() <= const Duration(seconds: 2))) {
        return;
      }

      cache.add(message);
      _updateLastMessage(convId, message);

      if (convId != activeConversationId) {
        final idx = conversations.indexWhere((c) => c.id == convId);
        if (idx != -1) {
          final conv = conversations[idx];
          conv.unreadCount++;
          conv.firstUnreadAt ??= message.createdAt;
          conversations.refresh();
        }
      }
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
