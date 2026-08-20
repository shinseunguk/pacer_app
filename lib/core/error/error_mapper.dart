import 'package:dio/dio.dart';

import 'failure.dart';

const _unauthorized = 401;
const _paymentRequired = 402;
const _serverErrorFloor = 500;

/// Converts transport errors into domain [Failure]s.
///
/// The server answers with `{ "error": { "code": "...", "message": "..." } }`,
/// so the Korean message is taken straight from the response when present.
Failure mapDioException(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.connectionError:
      return const NetworkFailure();
    case DioExceptionType.cancel:
      return const UnknownFailure('요청이 취소되었어요.');
    default:
      break;
  }

  final response = error.response;
  if (response == null) return const NetworkFailure();

  final status = response.statusCode;
  final parsed = _parseErrorBody(response.data);

  if (status == _unauthorized) {
    return AuthFailure(parsed?.message ?? '다시 로그인해주세요.', parsed?.code);
  }

  // 402는 오류가 아니라 페이월로 가야 할 신호다.
  if (status == _paymentRequired) {
    return PaymentRequiredFailure(
      parsed?.message ?? '이용권이 필요해요.',
      code: parsed?.code,
    );
  }

  if (status != null && status >= _serverErrorFloor) {
    return ServerFailure(
      parsed?.message ?? '서버에 문제가 생겼어요. 잠시 후 다시 시도해주세요.',
      code: parsed?.code,
      statusCode: status,
    );
  }

  return ServerFailure(
    parsed?.message ?? '요청을 처리하지 못했어요.',
    code: parsed?.code,
    statusCode: status,
  );
}

class _ErrorBody {
  const _ErrorBody(this.code, this.message);

  final String? code;
  final String? message;
}

_ErrorBody? _parseErrorBody(Object? data) {
  if (data is! Map) return null;

  final error = data['error'];
  if (error is! Map) return null;

  final code = error['code'];
  final message = error['message'];
  return _ErrorBody(
    code is String ? code : null,
    message is String ? message : null,
  );
}
