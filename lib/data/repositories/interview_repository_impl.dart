import 'package:dio/dio.dart';

import '../../core/error/error_mapper.dart';
import '../../domain/entities/interview_message.dart';
import '../../domain/entities/interview_report.dart';
import '../../domain/entities/interview_session.dart';
import '../../domain/entities/interview_setup.dart';
import '../../domain/entities/interview_turn_event.dart';
import '../../domain/repositories/interview_repository.dart';
import '../datasources/interview_remote_data_source.dart';
import '../datasources/sse_parser.dart';
import '../models/interview_models.dart';

class InterviewRepositoryImpl implements InterviewRepository {
  const InterviewRepositoryImpl(this._remote);

  final InterviewRemoteDataSource _remote;

  @override
  Future<CreatedInterview> create(InterviewSetup setup) {
    return _guard(() async => (await _remote.create(setup)).toEntity());
  }

  @override
  Stream<InterviewTurnEvent> submitAnswer(String sessionId, String content) {
    return _remote
        .submitAnswer(sessionId, content)
        .map(_toTurnEvent)
        .where((event) => event != null)
        .cast<InterviewTurnEvent>()
        .handleError((Object error) {
          throw error is DioException ? mapDioException(error) : error;
        });
  }

  @override
  Future<SkipResult> skip(String sessionId) {
    return _guard(() async => (await _remote.skip(sessionId)).toEntity());
  }

  @override
  Future<void> pause(String sessionId) {
    return _guard(() => _remote.pause(sessionId));
  }

  @override
  Future<ResumedInterview> resume(String sessionId) {
    return _guard(() async => (await _remote.resume(sessionId)).toEntity());
  }

  @override
  Future<InterviewReport> complete(String sessionId) {
    return _guard(
      () async => (await _remote.complete(sessionId)).report.toEntity(),
    );
  }

  @override
  Future<SessionFeedback> submitFeedback(
    String sessionId, {
    required FeedbackRating rating,
    String? comment,
  }) {
    return _guard(() async {
      final model = await _remote.submitFeedback(
        sessionId,
        rating: rating.value,
        comment: comment,
      );
      // 서버가 방금 저장한 값을 그대로 돌려주므로 파싱 실패는 없다고 본다.
      return model.toEntity() ?? SessionFeedback(rating: rating);
    });
  }

  @override
  Future<InterviewDetail> getDetail(String sessionId) {
    return _guard(() async => (await _remote.getDetail(sessionId)).toEntity());
  }

  @override
  Future<InterviewHistoryPage> getHistory({String? cursor, int? limit}) {
    return _guard(
      () async =>
          (await _remote.getHistory(cursor: cursor, limit: limit)).toEntity(),
    );
  }

  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      throw mapDioException(error);
    }
  }
}

/// SSE 이벤트(§8) → 도메인 이벤트. 모르는 이벤트는 무시한다.
InterviewTurnEvent? _toTurnEvent(SseEvent event) {
  final data = event.data;

  switch (event.event) {
    case 'message.delta':
      return TurnDelta(
        messageId: _string(data['messageId']),
        type: MessageType.fromValue(_string(data['type'])),
        delta: _string(data['delta']),
      );
    case 'message.done':
      final progress = data['progress'];
      return TurnDone(
        messageId: _string(data['messageId']),
        seq: _int(data['seq']),
        type: MessageType.fromValue(_string(data['type'])),
        parentId: data['parentId'] as String?,
        progress: progress is Map<String, dynamic>
            ? ProgressModel.fromJson(progress).toEntity()
            : const InterviewProgress(current: 0, total: 0),
      );
    case 'interview.done':
      return InterviewFinished(_string(data['sessionId']));
    case 'error':
      return TurnError(
        code: _string(data['code']),
        message: data['message'] is String
            ? data['message'] as String
            : '응답을 받지 못했어요. 다시 시도해주세요.',
      );
    default:
      return null;
  }
}

String _string(Object? value) => value is String ? value : '';

int _int(Object? value) => value is int ? value : 0;
