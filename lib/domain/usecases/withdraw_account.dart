import '../repositories/auth_repository.dart';
import '../repositories/user_repository.dart';

/// 회원 탈퇴 — 서버에 파기를 요청하고 기기의 세션도 지운다.
///
/// 개인정보 처리방침 §6("탈퇴를 통해 삭제를 요청할 수 있다")의 이행 경로다.
class WithdrawAccountUseCase {
  const WithdrawAccountUseCase({
    required UserRepository user,
    required AuthRepository auth,
  }) : _user = user,
       _auth = auth;

  final UserRepository _user;
  final AuthRepository _auth;

  Future<void> call() async {
    await _user.withdraw();
    // 서버가 재발급 경로를 끊었어도 기기에 남은 토큰은 직접 지운다.
    await _auth.signOut();
  }
}
