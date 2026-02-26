import 'package:endurance_mobile_app/services/api_client.dart';
import 'package:endurance_mobile_app/services/user/user_model.dart';

class UserService {
  Future<UserModel> getProfile() async {
    final response = await apiClient.get<Map<String, dynamic>>('/users');
    return UserModel.fromJson(response.data!);
  }
}
