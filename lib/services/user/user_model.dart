class UserModel {
  final String id;
  final String name;
  final String username;
  final String? about;
  final String? introduction;
  final String? image;

  const UserModel({
    required this.id,
    required this.name,
    required this.username,
    this.about,
    this.introduction,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      about: json['about']?.toString(),
      introduction: json['introduction']?.toString(),
      image: json['image']?.toString(),
    );
  }
}
