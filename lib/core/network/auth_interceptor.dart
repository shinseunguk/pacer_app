import 'package:dio/dio.dart';

import '../storage/token_storage.dart';
import 'api_paths.dart';

const _unauthorized = 401;
const _retriedFlag = 'pacer.retried';

/// Attaches the access token and refreshes it once on 401.
///
/// The server rotates refresh tokens, so a failed refresh means the session is
/// really gone → [onSessionExpired] lets the app drop back to the login screen.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required TokenStorage storage,
    required Dio refreshClient,
    required Future<void> Function() onSessionExpired,
  }) : _storage = storage,
       _refreshClient = refreshClient,
       _onSessionExpired = onSessionExpired;

  final TokenStorage _storage;
  final Dio _refreshClient;
  final Future<void> Function() _onSessionExpired;

  /// In-flight refresh shared by every request that hit 401 at the same time.
  Future<StoredTokens?>? _refreshing;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_isPublic(options.path)) return handler.next(options);

    final tokens = await _storage.read();
    if (tokens != null) {
      options.headers['Authorization'] = 'Bearer ${tokens.accessToken}';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final request = err.requestOptions;
    final canRetry =
        err.response?.statusCode == _unauthorized &&
        !_isPublic(request.path) &&
        request.extra[_retriedFlag] != true;

    if (!canRetry) return handler.next(err);

    final tokens = await _refreshOnce();
    if (tokens == null) {
      await _onSessionExpired();
      return handler.next(err);
    }

    try {
      request.extra[_retriedFlag] = true;
      request.headers['Authorization'] = 'Bearer ${tokens.accessToken}';
      final response = await _refreshClient.fetch<dynamic>(request);
      handler.resolve(response);
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }

  Future<StoredTokens?> _refreshOnce() {
    return _refreshing ??= _refresh().whenComplete(() => _refreshing = null);
  }

  Future<StoredTokens?> _refresh() async {
    final current = await _storage.read();
    if (current == null) return null;

    try {
      final response = await _refreshClient.post<Map<String, dynamic>>(
        ApiPaths.refresh,
        data: {'refreshToken': current.refreshToken},
      );

      final data = response.data;
      final access = data?['accessToken'];
      final refresh = data?['refreshToken'];
      if (access is! String || refresh is! String) return null;

      final rotated = StoredTokens(accessToken: access, refreshToken: refresh);
      await _storage.save(rotated);
      return rotated;
    } on DioException {
      await _storage.clear();
      return null;
    }
  }

  bool _isPublic(String path) =>
      path.startsWith('/auth/login') ||
      path.startsWith(ApiPaths.legal) ||
      path == ApiPaths.refresh ||
      path == ApiPaths.jobCategories;
}
