import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pacer_app/core/error/error_mapper.dart';
import 'package:pacer_app/core/error/failure.dart';

DioException _withResponse(int statusCode, Object? body) {
  final options = RequestOptions(path: '/interviews');
  return DioException(
    requestOptions: options,
    type: DioExceptionType.badResponse,
    response: Response<Object?>(
      requestOptions: options,
      statusCode: statusCode,
      data: body,
    ),
  );
}

void main() {
  test('서버 에러 포맷의 code·message를 그대로 전달한다', () {
    final failure = mapDioException(
      _withResponse(409, {
        'error': {'code': 'SESSION_COMPLETED', 'message': '이미 종료된 면접이에요.'},
      }),
    );

    expect(failure, isA<ServerFailure>());
    expect(failure.code, 'SESSION_COMPLETED');
    expect(failure.message, '이미 종료된 면접이에요.');
    expect((failure as ServerFailure).statusCode, 409);
  });

  test('401은 AuthFailure로 매핑한다', () {
    final failure = mapDioException(
      _withResponse(401, {
        'error': {'code': 'UNAUTHORIZED', 'message': '인증이 필요해요.'},
      }),
    );

    expect(failure, isA<AuthFailure>());
    expect(failure.code, 'UNAUTHORIZED');
  });

  test('연결 오류는 NetworkFailure', () {
    for (final type in [
      DioExceptionType.connectionError,
      DioExceptionType.connectionTimeout,
    ]) {
      final failure = mapDioException(
        DioException(requestOptions: RequestOptions(path: '/'), type: type),
      );
      expect(failure, isA<NetworkFailure>());
    }
  });

  test('본문이 예상 포맷이 아니어도 기본 메시지를 준다', () {
    final failure = mapDioException(_withResponse(500, 'oops'));

    expect(failure, isA<ServerFailure>());
    expect(failure.message, isNotEmpty);
    expect(failure.code, isNull);
  });
  group('타임아웃과 네트워크 오류를 나눈다', () {
    DioException withType(DioExceptionType type) => DioException(
      requestOptions: RequestOptions(path: '/interviews/1/complete'),
      type: type,
    );

    test('응답 지연은 네트워크 오류가 아니다', () {
      // 리포트 생성은 90초 넘게 걸린다. "네트워크를 확인하세요"라고 하면
      // 사용자가 와이파이를 껐다 켜며 엉뚱한 데를 본다.
      final failure = mapDioException(
        withType(DioExceptionType.receiveTimeout),
      );

      expect(failure, isA<TimeoutFailure>());
      expect(failure.message, contains('오래 걸리고'));
    });

    test('연결 자체가 안 되면 네트워크 오류다', () {
      expect(
        mapDioException(withType(DioExceptionType.connectionError)),
        isA<NetworkFailure>(),
      );
      expect(
        mapDioException(withType(DioExceptionType.connectionTimeout)),
        isA<NetworkFailure>(),
      );
    });
  });

}
