import 'package:dio/dio.dart';

import '../../core/error/error_mapper.dart';
import '../../core/storage/token_storage.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/social_provider.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../datasources/social_auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required AuthRemoteDataSource remote,
    required SocialAuthService social,
    required TokenStorage storage,
  }) : _remote = remote,
       _social = social,
       _storage = storage;

  final AuthRemoteDataSource _remote;
  final SocialAuthService _social;
  final TokenStorage _storage;

  @override
  Future<AuthSession> signIn(SocialProvider provider) async {
    try {
      final credential = await _social.authenticate(provider);
      final model = await _remote.login(
        provider,
        credential.idToken,
        nonce: credential.nonce,
      );

      await _storage.save(
        StoredTokens(
          accessToken: model.accessToken,
          refreshToken: model.refreshToken,
        ),
      );
      return model.toEntity();
    } on DioException catch (error) {
      throw mapDioException(error);
    }
  }

  @override
  Future<bool> hasStoredSession() async => await _storage.read() != null;

  @override
  Future<void> signOut() async {
    try {
      await _remote.logout();
    } on DioException {
      // 서버 호출이 실패해도 기기의 토큰은 반드시 지운다.
    } finally {
      await _storage.clear();
    }
  }
}
