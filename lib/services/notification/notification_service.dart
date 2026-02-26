import 'package:endurance_mobile_app/services/api_client.dart';
import 'package:endurance_mobile_app/services/notification/fcm_token_model.dart';

class NotificationService {
  Future<void> updateFcmToken(FcmTokenModel model) async {
    await apiClient.put<void>('/users/fcm-token', data: model.toJson());
  }
}
