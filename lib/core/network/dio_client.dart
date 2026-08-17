import 'package:dio/dio.dart';

import '../config/app_config.dart';

const _connectTimeout = Duration(seconds: 10);
const _receiveTimeout = Duration(seconds: 30);

/// Base Dio instance. Interceptors are attached by the caller so the refresh
/// client can stay free of the auth interceptor (avoids refresh recursion).
Dio createDio(AppConfig config) {
  return Dio(
    BaseOptions(
      baseUrl: config.apiBaseUrl,
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      contentType: Headers.jsonContentType,
      // Errors are mapped by the repositories; let Dio throw for non-2xx.
      validateStatus: (status) => status != null && status < 400,
    ),
  );
}
