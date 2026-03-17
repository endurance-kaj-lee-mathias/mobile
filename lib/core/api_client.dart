import 'package:dio/dio.dart';
import 'package:endurance_mobile_app/core/app_config.dart';
import 'package:endurance_mobile_app/services/auth/auth_controller.dart';
import 'package:get/get.dart' as getx;

final bool _enableVerboseLogging = false;

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

class _EmptyBodyInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final isParseError =
        err.type == DioExceptionType.unknown && err.error is FormatException;

    if (isParseError) {
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

    _pendingRefresh ??= _doRefresh().whenComplete(() {
      _pendingRefresh = null;
    });
    final refreshed = await _pendingRefresh!;

    if (!refreshed) {
      handler.next(err);
      return;
    }

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
      await auth.clearSession();
    }
    return ok;
  }
}
