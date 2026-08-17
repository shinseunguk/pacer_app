import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/interview_setup.dart';

/// S11 → S13에서 모으는 면접 설정 초안. 세션을 만들면 초기화한다.
final interviewSetupProvider =
    NotifierProvider<InterviewSetupNotifier, InterviewSetup>(
      InterviewSetupNotifier.new,
    );

class InterviewSetupNotifier extends Notifier<InterviewSetup> {
  @override
  InterviewSetup build() => const InterviewSetup();

  void setJobSource(JobSource source) {
    state = state.copyWith(jobSource: source);
  }

  void setJobPostingText(String text) {
    state = state.copyWith(jobPostingText: text);
  }

  void selectJobRole({required String id, required String name}) {
    state = state.copyWith(jobRoleId: id, jobRoleName: name, customRole: '');
  }

  void setCustomRole(String role) {
    state = state.clearJobRole().copyWith(customRole: role);
  }

  void setApplicantInfo(String info) {
    state = state.copyWith(applicantInfo: info);
  }

  void setInterviewType(InterviewType type) {
    state = state.copyWith(interviewType: type);
  }

  void setDifficulty(InterviewDifficulty difficulty) {
    state = state.copyWith(difficulty: difficulty);
  }

  void setQuestionCount(int count) {
    state = state.copyWith(
      questionCount: count.clamp(kMinQuestionCount, kMaxQuestionCount),
    );
  }

  void setShowScore(bool value) {
    state = state.copyWith(showScore: value);
  }

  void reset() {
    state = const InterviewSetup();
  }
}
