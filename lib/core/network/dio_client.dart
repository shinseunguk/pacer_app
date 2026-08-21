import 'package:dio/dio.dart';

import '../config/app_config.dart';

const _connectTimeout = Duration(seconds: 10);
const _receiveTimeout = Duration(seconds: 30);

/// 최종 평가(`POST /interviews/{id}/complete`) 전용 상한.
///
/// LLM이 대화록 전체를 읽고 항목별 점수와 질문별 모범답안까지 만든다.
/// **실측 90~105초**라 기본 30초로는 매번 타임아웃이 난다 — 서버는 정상적으로
/// 리포트를 만들어 저장하는데 앱만 못 받아서 "네트워크 오류"로 보였다.
const kReportTimeout = Duration(minutes: 3);

/// Base Dio instance. Interceptors are attached by the caller so the refresh
/// client can stay free of the auth interceptor (avoids refresh recursion).
Dio createDio(AppConfig config) {
  return Dio(
    BaseOptions(
      baseUrl: config.apiBaseUrl,
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      contentType: Headers.jsonContentType,
      // Errors are mapped by the repositories; let Dio throw for non-2xx.
      validateStatus: (status) => status != null && status < 400,
    ),
  );
}
