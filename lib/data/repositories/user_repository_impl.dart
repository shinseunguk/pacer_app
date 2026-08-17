import 'package:dio/dio.dart';

import '../../core/error/error_mapper.dart';
import '../../domain/entities/agreements.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(this._remote);

  final UserRemoteDataSource _remote;

  @override
  Future<UserProfile> getMyProfile() async {
    try {
      final model = await _remote.getMe();
      return model.toEntity();
    } on DioException catch (error) {
      throw mapDioException(error);
    }
  }

  @override
  Future<bool> isNicknameAvailable(String nickname) async {
    try {
      return await _remote.isNicknameAvailable(nickname);
    } on DioException catch (error) {
      throw mapDioException(error);
    }
  }

  @override
  Future<void> completeOnboarding({
    required String nickname,
    required Agreements agreements,
  }) async {
    try {
      await _remote.onboarding(nickname: nickname, agreements: agreements);
    } on DioException catch (error) {
      throw mapDioException(error);
    }
  }

  @override
  Future<UserProfile> updateNickname(String nickname) async {
    try {
      final model = await _remote.updateNickname(nickname);
      return model.toEntity();
    } on DioException catch (error) {
      throw mapDioException(error);
    }
  }

  @override
  Future<void> withdraw() async {
    try {
      await _remote.withdraw();
    } on DioException catch (error) {
      throw mapDioException(error);
    }
  }
}
