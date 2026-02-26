import 'package:dio/dio.dart';
import 'package:endurance_mobile_app/config/app_config.dart';
import 'package:endurance_mobile_app/services/auth/auth_controller.dart';
import 'package:get/get.dart' as getx;

/// Shared Dio instance used by all services.
///
/// Automatically attaches the Bearer token from [AuthController] to every
/// request and logs all traffic to the debug console.
final Dio apiClient = Dio(BaseOptions(baseUrl: AppConfig.apiBaseUrl))
  ..interceptors.addAll([
    _AuthInterceptor(),
    LogInterceptor(
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
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
