import 'package:dio/dio.dart';
import 'package:endurance_mobile_app/services/chat/chat_models.dart';
import 'package:get/get.dart';

class ChatService {
  ChatService({Dio? client}) : _client = client ?? Get.find<Dio>();

  final Dio _client;

  /// Returns all conversations that the current user participates in.
  ///
  /// Supports both the enriched summary format (`conversationId`, `firstName`,
  /// etc.) and the basic format (`id`, `participants`, `createdAt`), so the
  /// app stays functional regardless of which version the backend serves.
  Future<List<ConversationModel>> getConversations() async {
    final resp = await _client.get<List<dynamic>>('/chats');
    final list = (resp.data ?? []).cast<Map<String, dynamic>>();
    if (list.isEmpty) return [];
    final isEnriched = list.first.containsKey('conversationId');
    return list
        .map(isEnriched
            ? ConversationModel.fromSummaryJson
            : ConversationModel.fromJson)
        .toList();
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
