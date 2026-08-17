import '../../core/error/failure.dart';

/// User-facing text for anything that reaches `AsyncValue.error`.
/// Failures already carry a Korean message from the server or the use case.
String failureMessage(Object error) {
  if (error is Failure) return error.message;
  return '잠시 후 다시 시도해주세요.';
}
