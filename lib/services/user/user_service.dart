import 'package:dio/dio.dart';
import 'package:endurance_mobile_app/services/user/user_model.dart';
import 'package:get/get.dart';

class UserService {
  UserService({Dio? client}) : _client = client ?? Get.find<Dio>();

  final Dio _client;

  Future<UserModel> getProfile() async {
    final response = await _client.get<Map<String, dynamic>>('/users');
    return UserModel.fromJson(response.data!);
  }
}
