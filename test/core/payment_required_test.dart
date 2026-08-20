import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pacer_app/core/error/error_mapper.dart';
import 'package:pacer_app/core/error/failure.dart';

DioException responseWith(int status, Map<String, Object?> body) {
  final options = RequestOptions(path: '/interviews');
  return DioException(
    requestOptions: options,
    response: Response<Map<String, Object?>>(
      requestOptions: options,
      statusCode: status,
      data: body,
    ),
    type: DioExceptionType.badResponse,
  );
}

void main() {
  test('402는 오류가 아니라 페이월 신호로 매핑한다', () {
    final failure = mapDioException(
      responseWith(402, {
        'error': {
          'code': 'FREE_QUOTA_EXCEEDED',
          'message': '무료 면접 2회를 모두 사용했어요.',
        },
      }),
    );

    expect(failure, isA<PaymentRequiredFailure>());
    expect(failure.code, 'FREE_QUOTA_EXCEEDED');
    expect(failure.message, '무료 면접 2회를 모두 사용했어요.');
  });

  test('문항 수 초과(PLAN_REQUIRED)도 같은 타입으로 온다', () {
    final failure = mapDioException(
      responseWith(402, {
        'error': {'code': 'PLAN_REQUIRED', 'message': '무료로는 5문항 면접만 진행할 수 있어요.'},
      }),
    );

    expect(failure, isA<PaymentRequiredFailure>());
    expect(failure.code, 'PLAN_REQUIRED');
  });

  test('402에 본문이 없어도 한국어 기본 문구를 준다', () {
    final failure = mapDioException(responseWith(402, const {}));

    expect(failure, isA<PaymentRequiredFailure>());
    expect(failure.message, isNotEmpty);
  });

  test('429(하루 상한)는 페이월이 아니다 — 결제로 풀리지 않는다', () {
    final failure = mapDioException(
      responseWith(429, {
        'error': {'code': 'DAILY_INTERVIEW_LIMIT', 'message': '오늘 시작할 수 있는 면접 수를 모두 사용했어요.'},
      }),
    );

    expect(failure, isA<ServerFailure>());
    expect(failure, isNot(isA<PaymentRequiredFailure>()));
  });
}
