import 'package:dio/dio.dart';
import 'package:endurance_mobile_app/services/chat/chat_models.dart';
import 'package:get/get.dart';

class ChatService {
  ChatService({Dio? client}) : _client = client ?? Get.find<Dio>();

  final Dio _client;

  Future<List<ConversationModel>> getConversations() async {
    final resp = await _client.get<List<dynamic>>('/chats');
    final list = (resp.data ?? []).cast<Map<String, dynamic>>();
    if (list.isEmpty) return [];
    final isEnriched = list.first.containsKey('otherUserId');
    return list
        .map(isEnriched
            ? ConversationModel.fromSummaryJson
            : ConversationModel.fromJson)
        .toList();
  }

  Future<ConversationModel> startConversation(String participantId) async {
    final resp = await _client.post<Map<String, dynamic>>(
      '/chats',
      data: {'participantId': participantId},
    );
    return ConversationModel.fromJson(resp.data!);
  }

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
