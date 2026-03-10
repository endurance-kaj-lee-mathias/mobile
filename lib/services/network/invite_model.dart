import 'package:endurance_mobile_app/services/network/member_model.dart';

class InviteUserModel {
  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final String? image;
  final MemberRole role;

  const InviteUserModel({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    this.image,
    this.role = MemberRole.unknown,
  });

  factory InviteUserModel.fromJson(Map<String, dynamic> json) {
    final img = json['image']?.toString() ?? '';
    return InviteUserModel(
      id: json['id']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      image: img.isEmpty ? null : img,
      role: MemberModel.parseRole(json['role']?.toString() ?? ''),
    );
  }

  String get displayName => '$firstName $lastName'.trim();
}

class InviteModel {
  final String id;
  final InviteUserModel sender;
  final InviteUserModel receiver;
  final String status;
  final String? note;
  final DateTime createdAt;

  const InviteModel({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.status,
    this.note,
    required this.createdAt,
  });

  factory InviteModel.fromJson(Map<String, dynamic> json) {
    return InviteModel(
      id: json['id']?.toString() ?? '',
      sender: InviteUserModel.fromJson(
        json['sender'] as Map<String, dynamic>,
      ),
      receiver: InviteUserModel.fromJson(
        json['receiver'] as Map<String, dynamic>,
      ),
      status: json['status']?.toString() ?? '',
      note: json['note']?.toString(),
      createdAt:
          DateTime.tryParse(json['createdAt']?.toString() ?? '') ??
          DateTime.now(),
    );
  }
}

class InviteListModel {
  final List<InviteModel> incoming;
  final List<InviteModel> outgoing;

  const InviteListModel({required this.incoming, required this.outgoing});

  factory InviteListModel.fromJson(Map<String, dynamic> json) {
    return InviteListModel(
      incoming:
          (json['incoming'] as List<dynamic>? ?? [])
              .cast<Map<String, dynamic>>()
              .map(InviteModel.fromJson)
              .toList(),
      outgoing:
          (json['outgoing'] as List<dynamic>? ?? [])
              .cast<Map<String, dynamic>>()
              .map(InviteModel.fromJson)
              .toList(),
    );
  }
}
