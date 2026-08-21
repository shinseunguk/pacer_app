/// Domain-level error. Data sources throw raw exceptions; repositories convert
/// them into a `Failure` so the presentation layer never sees Dio/HTTP types.
sealed class Failure implements Exception {
  const Failure(this.message, {this.code});

  /// User-facing message (Korean, provided by the server when available).
  final String message;

  /// Server error code such as `SESSION_COMPLETED`. Null for local failures.
  final String? code;

  @override
  String toString() => '$runtimeType(code: $code, message: $message)';
}

/// No connection — retrying usually helps.
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = '네트워크 연결을 확인해주세요.']);
}

/// 응답이 상한 안에 오지 않음.
///
/// [NetworkFailure]와 나눈 이유: 연결은 멀쩡한데 서버가 오래 걸리는 경우가 있다.
/// "네트워크를 확인하세요"라고 하면 사용자가 와이파이를 껐다 켜며 엉뚱한 데를 본다.
class TimeoutFailure extends Failure {
  const TimeoutFailure([
    super.message = '시간이 오래 걸리고 있어요. 잠시 후 다시 시도해주세요.',
  ]);
}

/// 4xx/5xx response carrying the server's `{ error: { code, message } }` body.
class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.code, this.statusCode});

  final int? statusCode;
}

/// 402 — 이용권이 필요하다. 오류로 띄우지 말고 페이월로 보낸다.
///
/// `FREE_QUOTA_EXCEEDED`(무료 2회 소진)와 `PLAN_REQUIRED`(무료가 5문항 초과 선택)를
/// 모두 포함한다. 서버 메시지를 그대로 들고 있어 페이월 밖에서도 쓸 수 있다.
class PaymentRequiredFailure extends Failure {
  const PaymentRequiredFailure(super.message, {super.code});
}

/// Session expired or refresh failed — the app must sign out.
class AuthFailure extends Failure {
  const AuthFailure([super.message = '다시 로그인해주세요.', String? code])
    : super(code: code);
}

/// Input rejected before the request was made.
class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {super.code});
}

/// 사용자가 소셜 로그인 창을 닫음 — 오류가 아니므로 화면에 띄우지 않는다.
class SignInCancelled extends Failure {
  const SignInCancelled() : super('', code: 'SIGN_IN_CANCELLED');
}

/// 사용자가 스토어 결제 창을 닫음 — 오류가 아니므로 화면에 띄우지 않는다
/// ([SignInCancelled]과 같은 원칙).
class PurchaseCancelled extends Failure {
  const PurchaseCancelled() : super('', code: 'PURCHASE_CANCELLED');
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = '잠시 후 다시 시도해주세요.']);
}
