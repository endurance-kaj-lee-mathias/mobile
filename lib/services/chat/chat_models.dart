class MessageModel {
  final String id;
  final String conversationId;
  final String senderId;
  final String content;
  final DateTime createdAt;

  const MessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.content,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id']?.toString() ?? '',
      conversationId: json['conversationId']?.toString() ?? '',
      senderId: json['senderId']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'].toString())
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'conversationId': conversationId,
        'senderId': senderId,
        'content': content,
        'createdAt': createdAt.toIso8601String(),
      };
}

class ConversationModel {
  final String id;
  final List<String> participants;
  final DateTime createdAt;

  // Enriched from the member list — not part of the API response.
  String? otherUserId;
  String? otherUserFirstName;
  String? otherUserLastName;
  String? otherUserImage;

  MessageModel? lastMessage;

  // Unread tracking — managed by ChatController, not persisted.
  int unreadCount;
  DateTime? firstUnreadAt;

  ConversationModel({
    required this.id,
    required this.participants,
    required this.createdAt,
    this.otherUserId,
    this.otherUserFirstName,
    this.otherUserLastName,
    this.otherUserImage,
    this.lastMessage,
    this.unreadCount = 0,
    this.firstUnreadAt,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id']?.toString() ?? '',
      participants: (json['participants'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'].toString())
          : DateTime.now(),
    );
  }

  /// Parses the response from `GET /chats`, which returns a pre-enriched
  /// summary including the other participant's profile and latest message.
  factory ConversationModel.fromSummaryJson(Map<String, dynamic> json) {
    final convId = json['conversationId']?.toString() ?? '';
    final latestText = json['latestMessage'] as String?;
    final latestSentBy = json['latestMessageSentBy']?.toString();
    final latestAtRaw = json['latestMessageAt']?.toString();

    MessageModel? lastMessage;
    if (latestText != null && latestAtRaw != null) {
      lastMessage = MessageModel(
        id: '',
        conversationId: convId,
        senderId: latestSentBy ?? '',
        content: latestText,
        createdAt: DateTime.parse(latestAtRaw),
      );
    }

    return ConversationModel(
      id: convId,
      participants: const [],
      createdAt: DateTime.now(),
      otherUserId: json['otherUserId']?.toString(),
      otherUserFirstName: json['firstName']?.toString(),
      otherUserLastName: json['lastName']?.toString(),
      otherUserImage: json['imageUrl']?.toString(),
      lastMessage: lastMessage,
    );
  }

  String get displayName {
    final first = otherUserFirstName ?? '';
    final last = otherUserLastName ?? '';
    return '$first $last'.trim().isNotEmpty ? '$first $last'.trim() : 'Unknown';
  }
}

/// A message broadcast from the WebSocket server to subscribed clients.
class WsOutboundMessage {
  final String channel;
  final String from;
  final dynamic payload;

  WsOutboundMessage({
    required this.channel,
    required this.from,
    required this.payload,
  });

  factory WsOutboundMessage.fromJson(Map<String, dynamic> json) {
    return WsOutboundMessage(
      channel: json['channel']?.toString() ?? '',
      from: json['from']?.toString() ?? '',
      payload: json['payload'],
    );
  }
}
