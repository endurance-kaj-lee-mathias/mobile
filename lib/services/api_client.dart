import 'package:dio/dio.dart';
import 'package:endurance_mobile_app/config/app_config.dart';
import 'package:endurance_mobile_app/services/auth/auth_controller.dart';
import 'package:get/get.dart' as getx;
import 'package:flutter/foundation.dart';

final bool _enableVerboseLogging = !kReleaseMode;

Dio buildApiClient() =>
    Dio(BaseOptions(baseUrl: AppConfig.apiBaseUrl))
      ..interceptors.addAll([
        _AuthInterceptor(),
        if (_enableVerboseLogging)
          LogInterceptor(
            requestHeader: true,
            requestBody: true,
            responseHeader: true,
            responseBody: true,
            error: true,
          ),
      ]);

class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final auth = getx.Get.find<AuthController>();
    final token = auth.authorizationHeader;
    if (token != null) {
      options.headers['Authorization'] = token;
    }
    handler.next(options);
  }
}
