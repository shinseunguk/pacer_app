import '../entities/interview_report.dart';
import '../entities/interview_session.dart';
import '../entities/interview_setup.dart';
import '../entities/interview_turn_event.dart';
import '../entities/job_category.dart';
import '../repositories/interview_repository.dart';
import '../repositories/job_repository.dart';

class GetJobCategoriesUseCase {
  const GetJobCategoriesUseCase(this._repository);

  final JobRepository _repository;

  Future<List<JobCategory>> call() => _repository.getCategories();
}

class CreateInterviewUseCase {
  const CreateInterviewUseCase(this._repository);

  final InterviewRepository _repository;

  Future<CreatedInterview> call(InterviewSetup setup) =>
      _repository.create(setup);
}

class SubmitAnswerUseCase {
  const SubmitAnswerUseCase(this._repository);

  final InterviewRepository _repository;

  Stream<InterviewTurnEvent> call(String sessionId, String content) =>
      _repository.submitAnswer(sessionId, content);
}

class SkipQuestionUseCase {
  const SkipQuestionUseCase(this._repository);

  final InterviewRepository _repository;

  Future<SkipResult> call(String sessionId) => _repository.skip(sessionId);
}

class PauseInterviewUseCase {
  const PauseInterviewUseCase(this._repository);

  final InterviewRepository _repository;

  Future<void> call(String sessionId) => _repository.pause(sessionId);
}

class ResumeInterviewUseCase {
  const ResumeInterviewUseCase(this._repository);

  final InterviewRepository _repository;

  Future<ResumedInterview> call(String sessionId) =>
      _repository.resume(sessionId);
}

class CompleteInterviewUseCase {
  const CompleteInterviewUseCase(this._repository);

  final InterviewRepository _repository;

  Future<InterviewReport> call(String sessionId) =>
      _repository.complete(sessionId);
}

class GetInterviewDetailUseCase {
  const GetInterviewDetailUseCase(this._repository);

  final InterviewRepository _repository;

  Future<InterviewDetail> call(String sessionId) =>
      _repository.getDetail(sessionId);
}

class GetInterviewHistoryUseCase {
  const GetInterviewHistoryUseCase(this._repository);

  final InterviewRepository _repository;

  Future<InterviewHistoryPage> call({String? cursor, int? limit}) =>
      _repository.getHistory(cursor: cursor, limit: limit);
}
