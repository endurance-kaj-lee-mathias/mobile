class UserModel {
  final String id;
  final String firstName;
  final String? lastName;
  final String username;
  final String? about;
  final String? introduction;
  final String? image;

  const UserModel({
    required this.id,
    required this.firstName,
    this.lastName,
    required this.username,
    this.about,
    this.introduction,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      firstName: json['first-name']?.toString() ?? '',
      lastName: json['last-name']?.toString(),
      username: json['username']?.toString() ?? '',
      about: json['about']?.toString(),
      introduction: json['introduction']?.toString(),
      image: json['image']?.toString(),
    );
  }
}
