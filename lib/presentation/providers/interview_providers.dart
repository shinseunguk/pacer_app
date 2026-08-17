import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/interview_remote_data_source.dart';
import '../../data/datasources/job_remote_data_source.dart';
import '../../data/repositories/interview_repository_impl.dart';
import '../../data/repositories/job_repository_impl.dart';
import '../../domain/entities/interview_report.dart';
import '../../domain/entities/interview_session.dart';
import '../../domain/entities/job_category.dart';
import '../../domain/repositories/interview_repository.dart';
import '../../domain/repositories/job_repository.dart';
import '../../domain/usecases/interview_usecases.dart';
import 'app_providers.dart';

final jobRepositoryProvider = Provider<JobRepository>(
  (ref) => JobRepositoryImpl(JobRemoteDataSource(ref.watch(dioProvider))),
);

final interviewRepositoryProvider = Provider<InterviewRepository>(
  (ref) => InterviewRepositoryImpl(
    InterviewRemoteDataSource(ref.watch(dioProvider)),
  ),
);

final getJobCategoriesProvider = Provider(
  (ref) => GetJobCategoriesUseCase(ref.watch(jobRepositoryProvider)),
);

final createInterviewProvider = Provider(
  (ref) => CreateInterviewUseCase(ref.watch(interviewRepositoryProvider)),
);

final submitAnswerProvider = Provider(
  (ref) => SubmitAnswerUseCase(ref.watch(interviewRepositoryProvider)),
);

final skipQuestionProvider = Provider(
  (ref) => SkipQuestionUseCase(ref.watch(interviewRepositoryProvider)),
);

final pauseInterviewProvider = Provider(
  (ref) => PauseInterviewUseCase(ref.watch(interviewRepositoryProvider)),
);

final resumeInterviewProvider = Provider(
  (ref) => ResumeInterviewUseCase(ref.watch(interviewRepositoryProvider)),
);

final completeInterviewProvider = Provider(
  (ref) => CompleteInterviewUseCase(ref.watch(interviewRepositoryProvider)),
);

final getInterviewDetailProvider = Provider(
  (ref) => GetInterviewDetailUseCase(ref.watch(interviewRepositoryProvider)),
);

final getInterviewHistoryProvider = Provider(
  (ref) => GetInterviewHistoryUseCase(ref.watch(interviewRepositoryProvider)),
);

/// S11a — 직무 카테고리 트리.
final jobCategoriesProvider = FutureProvider.autoDispose<List<JobCategory>>(
  (ref) => ref.watch(getJobCategoriesProvider)(),
);

/// S40 — 히스토리 첫 페이지.
final interviewHistoryProvider =
    FutureProvider.autoDispose<InterviewHistoryPage>(
      (ref) => ref.watch(getInterviewHistoryProvider)(),
    );

/// S41 — 대화 전문.
final interviewDetailProvider = FutureProvider.autoDispose
    .family<InterviewDetail, String>(
      (ref, sessionId) => ref.watch(getInterviewDetailProvider)(sessionId),
    );

/// S30 — 최종 리포트. complete는 멱등이라 재진입해도 같은 리포트를 돌려준다.
final interviewReportProvider = FutureProvider.autoDispose
    .family<InterviewReport, String>(
      (ref, sessionId) => ref.watch(completeInterviewProvider)(sessionId),
    );

/// 연속 연습일(스트릭) — 성장 API(P1) 전까지 히스토리에서 계산한다.
final practiceStreakProvider = Provider.autoDispose<int>((ref) {
  final page = ref.watch(interviewHistoryProvider).valueOrNull;
  if (page == null) return 0;

  final days = page.items
      .map((item) => _dateOnly(item.createdAt.toLocal()))
      .toSet();
  return _countStreak(days, _dateOnly(DateTime.now()));
});

DateTime _dateOnly(DateTime value) =>
    DateTime(value.year, value.month, value.day);

/// 오늘(또는 어제)부터 하루도 빠지지 않고 이어진 날 수.
int _countStreak(Set<DateTime> days, DateTime today) {
  var cursor = today;
  if (!days.contains(cursor)) {
    cursor = today.subtract(const Duration(days: 1));
    if (!days.contains(cursor)) return 0;
  }

  var count = 0;
  while (days.contains(cursor)) {
    count += 1;
    cursor = _dateOnly(cursor.subtract(const Duration(days: 1)));
  }
  return count;
}
