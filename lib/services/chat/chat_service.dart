import 'package:dio/dio.dart';
import 'package:endurance_mobile_app/services/chat/chat_models.dart';
import 'package:get/get.dart';

class ChatService {
  ChatService({Dio? client}) : _client = client ?? Get.find<Dio>();

  final Dio _client;

  /// Returns all conversations that the current user participates in.
  Future<List<ConversationModel>> getConversations() async {
    final resp = await _client.get<List<dynamic>>('/chats');
    return (resp.data ?? [])
        .cast<Map<String, dynamic>>()
        .map(ConversationModel.fromJson)
        .toList();
  }

  /// Returns basic profile info for [userId]. Used to enrich conversations
  /// when the other participant is not in the current user's network member list.
  Future<Map<String, dynamic>> getUser(String userId) async {
    final resp = await _client.get<Map<String, dynamic>>('/users/$userId');
    return resp.data ?? {};
  }

  /// Creates a new conversation with [participantId] or returns the existing one.
  /// [participantId] must be the user UUID (MemberModel.veteran), not the support ID.
  Future<ConversationModel> startConversation(String participantId) async {
    final resp = await _client.post<Map<String, dynamic>>(
      '/chats',
      data: {'participantId': participantId},
    );
    return ConversationModel.fromJson(resp.data!);
  }

  /// Returns messages for [conversationId] ordered by [createdAt] descending
  /// (newest first from the API). Frontend reverses for display.
  Future<List<MessageModel>> getMessages(
    String conversationId, {
    int limit = 30,
    int offset = 0,
  }) async {
    final resp = await _client.get<List<dynamic>>(
      '/chats/$conversationId/messages',
      queryParameters: {'limit': limit, 'offset': offset},
    );
    return (resp.data ?? [])
        .cast<Map<String, dynamic>>()
        .map(MessageModel.fromJson)
        .toList();
  }

  /// Sends [content] to [conversationId] and returns the persisted message.
  Future<MessageModel> sendMessage(
    String conversationId,
    String content,
  ) async {
    final resp = await _client.post<Map<String, dynamic>>(
      '/chats/$conversationId/messages',
      data: {'content': content},
    );
    return MessageModel.fromJson(resp.data!);
  }
}
