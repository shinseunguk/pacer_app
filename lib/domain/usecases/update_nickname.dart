import '../entities/user_profile.dart';
import '../repositories/user_repository.dart';
import '../validation/nickname_rule.dart';
import 'check_nickname.dart';

/// 닉네임 수정 (마이 → 프로필 편집).
class UpdateNicknameUseCase {
  const UpdateNicknameUseCase(this._repository);

  final UserRepository _repository;

  /// 온보딩과 같은 규칙을 적용한다. 중복 최종 판정은 서버(409)가 한다.
  ///
  /// 규칙 위반도 예외를 동기적으로 던지지 않고 Future로 전달한다
  /// (호출부가 오류 처리 경로를 하나로 유지할 수 있게).
  Future<UserProfile> call(String nickname) async {
    final violation = findNicknameViolation(nickname);
    if (violation != null) throw nicknameViolationFailure(violation);

    return _repository.updateNickname(normalizeNickname(nickname));
  }
}
