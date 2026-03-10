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
  // Prevents multiple concurrent refreshes when several requests 401 at once.
  Future<bool>? _pendingRefresh;

  static const _retriedKey = '_auth_retried';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final auth = getx.Get.find<AuthController>();
    final header = auth.authorizationHeader;
    if (header != null) {
      options.headers['Authorization'] = header;
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final is401 = err.response?.statusCode == 401;
    final alreadyRetried = err.requestOptions.extra[_retriedKey] == true;

    if (!is401 || alreadyRetried) {
      handler.next(err);
      return;
    }

    // Collapse concurrent refreshes into one network call.
    _pendingRefresh ??= _doRefresh().whenComplete(() {
      _pendingRefresh = null;
    });
    final refreshed = await _pendingRefresh!;

    if (!refreshed) {
      handler.next(err);
      return;
    }

    // Retry the original request with the new token.
    try {
      final auth = getx.Get.find<AuthController>();
      final retryOptions = err.requestOptions
        ..extra[_retriedKey] = true
        ..headers['Authorization'] = auth.authorizationHeader;
      final dio = getx.Get.find<Dio>();
      final response = await dio.fetch<dynamic>(retryOptions);
      handler.resolve(response);
    } catch (retryError) {
      handler.next(err);
    }
  }

  Future<bool> _doRefresh() async {
    final auth = getx.Get.find<AuthController>();
    final ok = await auth.refreshTokens();
    if (!ok) {
      // Refresh token is also expired — clear the session so the router
      // sends the user back to the login screen.
      await auth.clearSession();
    }
    return ok;
  }
}
