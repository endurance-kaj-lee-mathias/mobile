enum MemberRole { support, therapist, veteran, unknown }

class MemberModel {
  final String id;
  final String veteran;
  final String email;
  final String firstName;
  final String lastName;
  final String username;
  final String? image;
  final MemberRole role;

  const MemberModel({
    required this.id,
    required this.veteran,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.username,
    this.image,
    this.role = MemberRole.unknown,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    final img = json['image']?.toString() ?? '';
    final roleStr = json['role']?.toString() ?? '';
    return MemberModel(
      id: json['id']?.toString() ?? '',
      veteran: json['veteran']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      image: img.isEmpty ? null : img,
      role: parseRole(roleStr),
    );
  }

  static MemberRole parseRole(String raw) => switch (raw.toUpperCase()) {
        'SUPPORT' => MemberRole.support,
        'THERAPIST' => MemberRole.therapist,
        'VETERAN' => MemberRole.veteran,
        _ => MemberRole.unknown,
      };

  String get displayName => '$firstName $lastName'.trim();
}
