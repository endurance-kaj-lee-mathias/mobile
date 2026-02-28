import 'package:dio/dio.dart';
import 'package:endurance_mobile_app/services/notification/fcm_token_model.dart';
import 'package:get/get.dart';

class NotificationService {
  NotificationService({Dio? client}) : _client = client ?? Get.find<Dio>();

  final Dio _client;

  Future<void> updateFcmToken(FcmTokenModel model) async {
    await _client.put<void>('/users/device', data: model.toJson());
  }

  Future<void> deleteFcmToken() async {
    await _client.delete<void>('/users/device');
  }
}
