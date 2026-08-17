import '../entities/interview_report.dart';
import '../entities/interview_session.dart';
import '../entities/interview_setup.dart';
import '../entities/interview_turn_event.dart';

abstract interface class InterviewRepository {
  Future<CreatedInterview> create(InterviewSetup setup);

  /// 답변 제출 → 다음 발화를 SSE로 흘려받는다.
  Stream<InterviewTurnEvent> submitAnswer(String sessionId, String content);

  Future<SkipResult> skip(String sessionId);

  Future<void> pause(String sessionId);

  Future<ResumedInterview> resume(String sessionId);

  Future<InterviewReport> complete(String sessionId);

  Future<InterviewDetail> getDetail(String sessionId);

  Future<InterviewHistoryPage> getHistory({String? cursor, int? limit});
}
