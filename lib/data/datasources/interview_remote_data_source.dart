import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../../core/network/api_paths.dart';
import '../../core/network/dio_client.dart';
import '../../domain/entities/interview_setup.dart';
import '../models/interview_models.dart';
import 'sse_parser.dart';

class InterviewRemoteDataSource {
  const InterviewRemoteDataSource(this._dio);

  final Dio _dio;

  Future<CreatedInterviewModel> create(InterviewSetup setup) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiPaths.interviews,
      data: _createBody(setup),
    );
    return CreatedInterviewModel.fromJson(response.data ?? const {});
  }

  /// 답변 제출 — `text/event-stream` 응답을 이벤트 단위로 흘려준다.
  Stream<SseEvent> submitAnswer(String sessionId, String content) async* {
    final Response<ResponseBody> response;
    try {
      response = await _dio.post<ResponseBody>(
        ApiPaths.answer(sessionId),
        data: {'content': content},
        options: Options(
          responseType: ResponseType.stream,
          headers: {'Accept': 'text/event-stream'},
        ),
      );
    } on DioException catch (error) {
      // 스트림을 열기 전 오류(402·409 등)는 본문이 스트림으로 와서 그대로는 못 읽는다.
      throw await _decodeStreamedError(error);
    }

    final body = response.data;
    if (body == null) return;

    yield* parseSseStream(
      body.stream.cast<List<int>>().transform(utf8.decoder),
    );
  }

  Future<SkipResultModel> skip(String sessionId) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiPaths.skip(sessionId),
    );
    return SkipResultModel.fromJson(response.data ?? const {});
  }

  Future<void> pause(String sessionId) =>
      _dio.post<void>(ApiPaths.pause(sessionId));

  Future<ResumedInterviewModel> resume(String sessionId) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiPaths.resume(sessionId),
    );
    return ResumedInterviewModel.fromJson(response.data ?? const {});
  }

  /// 평가는 LLM이 대화록 전체를 읽어야 해서 오래 걸린다 — 전용 상한을 준다.
  Future<CompleteInterviewModel> complete(String sessionId) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiPaths.complete(sessionId),
      options: Options(receiveTimeout: kReportTimeout),
    );
    return CompleteInterviewModel.fromJson(response.data ?? const {});
  }

  Future<SessionFeedbackModel> submitFeedback(
    String sessionId, {
    required String rating,
    String? comment,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiPaths.interviewFeedback(sessionId),
      data: {'rating': rating, if (comment != null) 'comment': comment},
    );
    return SessionFeedbackModel.fromJson(response.data ?? const {});
  }

  Future<InterviewDetailModel> getDetail(String sessionId) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiPaths.interview(sessionId),
    );
    return InterviewDetailModel.fromJson(response.data ?? const {});
  }

  Future<InterviewHistoryPageModel> getHistory({
    String? cursor,
    int? limit,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiPaths.interviews,
      queryParameters: {
        if (cursor != null) 'cursor': cursor,
        if (limit != null) 'limit': limit,
      },
    );
    return InterviewHistoryPageModel.fromJson(response.data ?? const {});
  }

  Map<String, dynamic> _createBody(InterviewSetup setup) {
    final customRole = setup.customRole?.trim();

    return {
      'jobSource': setup.jobSource.value,
      if (setup.jobPostingText.trim().isNotEmpty)
        'jobPostingText': setup.jobPostingText.trim(),
      if (setup.jobRoleId != null) 'jobRoleId': setup.jobRoleId,
      if (customRole != null && customRole.isNotEmpty) 'customRole': customRole,
      if (setup.applicantInfo.trim().isNotEmpty)
        'applicantInfo': setup.applicantInfo.trim(),
      'interviewType': setup.interviewType.value,
      'difficulty': setup.difficulty.value,
      'questionCount': setup.questionCount,
      'showScore': setup.showScore,
    };
  }

  /// 스트림으로 받은 에러 본문을 JSON으로 바꿔 일반 에러 매핑을 태운다.
  Future<DioException> _decodeStreamedError(DioException error) async {
    final body = error.response?.data;
    if (body is! ResponseBody) return error;

    final text = await utf8.decodeStream(body.stream.cast<List<int>>());
    Object? decoded;
    try {
      decoded = jsonDecode(text);
    } on FormatException {
      decoded = text;
    }

    return error.copyWith(
      response: Response<Object?>(
        requestOptions: error.requestOptions,
        statusCode: error.response?.statusCode,
        data: decoded,
      ),
    );
  }
}
