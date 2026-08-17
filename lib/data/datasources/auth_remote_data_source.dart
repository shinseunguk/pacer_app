import 'package:dio/dio.dart';

import '../../core/network/api_paths.dart';
import '../../domain/entities/social_provider.dart';
import '../models/auth_session_model.dart';

class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._dio);

  final Dio _dio;

  Future<AuthSessionModel> login(
    SocialProvider provider,
    String idToken, {
    String? nonce,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiPaths.login(provider.value),
      data: {'idToken': idToken, if (nonce != null) 'nonce': nonce},
    );

    return AuthSessionModel.fromJson(response.data ?? const {});
  }

  Future<void> logout() => _dio.post<void>(ApiPaths.logout);
}
