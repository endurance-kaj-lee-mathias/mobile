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
        _EmptyBodyInterceptor(),
        if (_enableVerboseLogging)
          LogInterceptor(
            requestHeader: true,
            requestBody: true,
            responseHeader: true,
            responseBody: true,
            error: true,
          ),
      ]);

/// Silently handles 2xx responses with no body (e.g. 204 No Content).
/// Dio tries to JSON-decode empty bodies by default, throwing a
/// FormatException wrapped in DioException [unknown]. This interceptor
/// resolves those as successful empty responses instead.
class _EmptyBodyInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final isParseError =
        err.type == DioExceptionType.unknown && err.error is FormatException;

    if (isParseError) {
      // Dio throws this when it tries to JSON-decode an empty body (e.g. 204
      // No Content). err.response is null because the exception is raised
      // before Dio attaches the response object. Treat it as a success.
      final status = err.response?.statusCode ?? 204;
      handler.resolve(
        Response<void>(
          requestOptions: err.requestOptions,
          statusCode: status,
          statusMessage: err.response?.statusMessage,
        ),
      );
      return;
    }
    handler.next(err);
  }
}

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
