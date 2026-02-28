class FcmTokenModel {
  final String token;
  final String platform;

  const FcmTokenModel({required this.token, required this.platform});

  Map<String, dynamic> toJson() => {'token': token, 'platform': platform};
}
