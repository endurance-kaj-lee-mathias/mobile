import 'dart:io';

import 'package:endurance_mobile_app/app/router.dart';
import 'package:endurance_mobile_app/services/auth/auth_controller.dart';
import 'package:endurance_mobile_app/services/network/network_controller.dart';
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
  String? _pendingRoute;

  @override
  void onInit() {
    super.onInit();
    _initHandlers();

    final auth = Get.find<AuthController>();
    ever(auth.isAuthenticated, (bool authenticated) {
      if (authenticated) {
        _syncToken();
        if (auth.isVeteran && _pendingRoute != null) {
          final route = _pendingRoute!;
          _pendingRoute = null;
          router.push(route);
        }
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

      // When the backend sends a push for a new/updated network invite,
      // refresh the network controller so the badge and list update instantly.
      // The backend should set data['type'] = 'network_invite' on those pushes.
      if (message.data['type'] == 'network_invite') {
        Get.find<NetworkController>().handlePushNotification();
      }
    });

    _fcm.onTokenRefresh.listen(_sendToken);
  }

  Future<void> _syncToken() async {
    try {
      await _fcm.requestPermission();
      if (Platform.isIOS) {
        // APNS token must be available before getToken() works on iOS.
        // Poll briefly to wait for iOS to register with APNs.
        String? apns;
        for (var i = 0; i < 10 && apns == null; i++) {
          apns = await _fcm.getAPNSToken();
          if (apns == null) await Future.delayed(const Duration(seconds: 1));
        }
        if (apns == null) {
          debugPrint('APNS token unavailable; skipping FCM token sync');
          return;
        }
      }
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
    debugPrint('Notification tapped: ${message.data}');
    final route = message.data['route'] as String?;
    if (route == null) return;

    final auth = Get.find<AuthController>();
    if (auth.isAuthenticated.value && auth.isVeteran) {
      router.push(route);
    } else {
      _pendingRoute = route;
    }
  }
}
