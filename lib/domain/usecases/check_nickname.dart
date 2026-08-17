import '../../core/error/failure.dart';
import '../repositories/user_repository.dart';
import '../validation/nickname_rule.dart';

/// 닉네임 사용 가능 여부 (온보딩 실시간 확인).
class CheckNicknameUseCase {
  const CheckNicknameUseCase(this._repository);

  final UserRepository _repository;

  /// 형식이 어긋나면 서버에 묻지 않고 바로 막는다(불필요한 호출 방지).
  Future<bool> call(String nickname) async {
    final violation = findNicknameViolation(nickname);
    if (violation != null) throw nicknameViolationFailure(violation);

    return _repository.isNicknameAvailable(normalizeNickname(nickname));
  }
}

/// 규칙 위반을 사용자 문구로 바꾼다 (서버 메시지와 같은 내용).
ValidationFailure nicknameViolationFailure(NicknameViolation violation) {
  return switch (violation) {
    NicknameViolation.length => const ValidationFailure(
      '닉네임은 $nicknameMinLength~$nicknameMaxLength자로 입력해주세요.',
      code: 'INVALID_NICKNAME',
    ),
    NicknameViolation.charset => const ValidationFailure(
      '닉네임에는 한글·영문·숫자·이모지만 쓸 수 있어요.',
      code: 'INVALID_NICKNAME',
    ),
  };
}
