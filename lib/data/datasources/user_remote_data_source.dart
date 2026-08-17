import 'package:dio/dio.dart';

import '../../core/network/api_paths.dart';
import '../../domain/entities/agreements.dart';
import '../models/user_profile_model.dart';

class UserRemoteDataSource {
  const UserRemoteDataSource(this._dio);

  final Dio _dio;

  Future<bool> isNicknameAvailable(String nickname) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiPaths.nicknameAvailability,
      queryParameters: {'nickname': nickname},
    );
    return response.data?['available'] == true;
  }

  Future<UserProfileModel> getMe() async {
    final response = await _dio.get<Map<String, dynamic>>(ApiPaths.me);
    return UserProfileModel.fromJson(response.data ?? const {});
  }

  Future<void> onboarding({
    required String nickname,
    required Agreements agreements,
  }) {
    return _dio.post<void>(
      ApiPaths.onboarding,
      data: {
        'nickname': nickname,
        'agreements': {
          'terms': agreements.terms,
          'privacy': agreements.privacy,
          'llmConsent': agreements.llmConsent,
          'marketing': agreements.marketing,
        },
      },
    );
  }

  Future<UserProfileModel> updateNickname(String nickname) async {
    final response = await _dio.patch<Map<String, dynamic>>(
      ApiPaths.me,
      data: {'nickname': nickname},
    );
    return UserProfileModel.fromJson(response.data ?? const {});
  }

  Future<void> withdraw() => _dio.delete<void>(ApiPaths.me);
}
