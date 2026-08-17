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

/// No connection / timeout — retrying usually helps.
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = '네트워크 연결을 확인해주세요.']);
}

/// 4xx/5xx response carrying the server's `{ error: { code, message } }` body.
class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.code, this.statusCode});

  final int? statusCode;
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

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = '잠시 후 다시 시도해주세요.']);
}
