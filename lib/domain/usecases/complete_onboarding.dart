import '../../core/error/failure.dart';
import '../entities/agreements.dart';
import '../repositories/user_repository.dart';
import '../validation/nickname_rule.dart';
import 'check_nickname.dart';

class CompleteOnboardingUseCase {
  const CompleteOnboardingUseCase(this._repository);

  final UserRepository _repository;

  /// Validates locally first so the user sees the error without a round trip.
  /// The server enforces the same rules (422 / 400).
  Future<void> call({
    required String nickname,
    required Agreements agreements,
  }) async {
    final violation = findNicknameViolation(nickname);
    if (violation != null) throw nicknameViolationFailure(violation);

    final trimmed = normalizeNickname(nickname);
    if (!agreements.allRequiredAccepted) {
      throw const ValidationFailure(
        '필수 항목에 모두 동의해야 시작할 수 있어요.',
        code: 'AGREEMENT_REQUIRED',
      );
    }

    await _repository.completeOnboarding(
      nickname: trimmed,
      agreements: agreements,
    );
  }
}
