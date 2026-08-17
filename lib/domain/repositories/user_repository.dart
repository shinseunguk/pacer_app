import '../entities/agreements.dart';
import '../entities/user_profile.dart';

abstract interface class UserRepository {
  Future<UserProfile> getMyProfile();

  /// 닉네임을 다른 사용자가 쓰고 있지 않은지 확인한다.
  Future<bool> isNicknameAvailable(String nickname);

  Future<void> completeOnboarding({
    required String nickname,
    required Agreements agreements,
  });

  Future<UserProfile> updateNickname(String nickname);

  Future<void> withdraw();
}
