import 'dart:io';

import 'package:endurance_mobile_app/services/auth/auth_controller.dart';
import 'package:endurance_mobile_app/services/notification/fcm_token_model.dart';
import 'package:endurance_mobile_app/services/notification/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

@pragma('vm:entry-point')
Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  // FCM shows the notification automatically.
  // Handle silent/data-only messages here if needed.
}

class NotificationController extends GetxController {
  NotificationController({NotificationService? notificationService})
    : _notificationService = notificationService ?? NotificationService();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final NotificationService _notificationService;

  @override
  void onInit() {
    super.onInit();
    _initHandlers();

    final auth = Get.find<AuthController>();
    ever(auth.isAuthenticated, (bool authenticated) {
      if (authenticated) {
        _syncToken();
      } else {
        _clearToken();
      }
    });

    if (auth.isAuthenticated.value) _syncToken();
  }

  Future<void> _initHandlers() async {
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);

    // App was fully terminated when notification was tapped
    final initial = await _fcm.getInitialMessage();
    if (initial != null) _handleMessage(initial);

    // Tapped while app was in background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    // Foreground messages (app is open)
    FirebaseMessaging.onMessage.listen((message) {
      debugPrint('Foreground message: ${message.notification?.title}');
      // Show an in-app banner here if desired
    });

    _fcm.onTokenRefresh.listen(_sendToken);
  }

  Future<void> _syncToken() async {
    try {
      await _fcm.requestPermission();
      final token = await _fcm.getToken();
      if (token != null) await _sendToken(token);
    } catch (e) {
      debugPrint('Failed to sync FCM token: $e');
    }
  }

  Future<void> _clearToken() async {
    try {
      await _notificationService.deleteFcmToken();
      await _fcm.deleteToken();
    } catch (e) {
      debugPrint('Failed to clear FCM token: $e');
    }
  }

  Future<void> _sendToken(String token) async {
    try {
      final model = FcmTokenModel(
        token: token,
        platform: Platform.isIOS ? 'ios' : 'android',
      );
      await _notificationService.updateFcmToken(model);
    } catch (e) {
      debugPrint('Failed to send FCM token to backend: $e');
    }
  }

  void _handleMessage(RemoteMessage message) {
    // Navigate based on message.data, e.g.:
    // final route = message.data['route'];
    // if (route != null) Get.toNamed(route);
    debugPrint('Notification tapped: ${message.data}');
  }
}
