import '../entities/interview_report.dart';
import '../repositories/interview_repository.dart';

/// 리포트 만족도 제출 (MVP 성공 기준 §6 "리포트 👍 비율").
class SubmitReportFeedbackUseCase {
  const SubmitReportFeedbackUseCase(this._repository);

  final InterviewRepository _repository;

  Future<SessionFeedback> call(
    String sessionId, {
    required FeedbackRating rating,
    String? comment,
  }) {
    final trimmed = comment?.trim();

    return _repository.submitFeedback(
      sessionId,
      rating: rating,
      comment: trimmed == null || trimmed.isEmpty ? null : trimmed,
    );
  }
}
