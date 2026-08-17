import 'interview_message.dart';
import 'interview_report.dart';

enum SessionStatus {
  inProgress('in_progress'),
  paused('paused'),
  completed('completed');

  const SessionStatus(this.value);

  final String value;

  static SessionStatus fromValue(String value) {
    return SessionStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => SessionStatus.inProgress,
    );
  }
}

/// `POST /interviews` 결과 — 세션 + 첫 질문.
class CreatedInterview {
  const CreatedInterview({
    required this.sessionId,
    required this.status,
    required this.progress,
    required this.firstQuestion,
  });

  final String sessionId;
  final SessionStatus status;
  final InterviewProgress progress;
  final InterviewMessage firstQuestion;
}

/// `POST /interviews/{id}/skip` 결과.
class SkipResult {
  const SkipResult({
    required this.next,
    required this.progress,
    required this.done,
  });

  final InterviewMessage? next;
  final InterviewProgress progress;

  /// 남은 기본 질문이 없어 종료(complete)로 넘어가야 하는 상태.
  final bool done;
}

/// `POST /interviews/{id}/resume` 결과 — 중단 지점 컨텍스트.
class ResumedInterview {
  const ResumedInterview({
    required this.status,
    required this.progress,
    required this.messages,
  });

  final SessionStatus status;
  final InterviewProgress progress;
  final List<InterviewMessage> messages;
}

/// 히스토리 목록 아이템 (S40).
class InterviewSummary {
  const InterviewSummary({
    required this.id,
    required this.role,
    required this.interviewType,
    required this.score,
    required this.passResult,
    required this.createdAt,
  });

  final String id;
  final String? role;
  final String interviewType;
  final int? score;
  final String? passResult;
  final DateTime createdAt;
}

class InterviewHistoryPage {
  const InterviewHistoryPage({required this.items, required this.nextCursor});

  final List<InterviewSummary> items;
  final String? nextCursor;
}

/// 대화 전문 재열람 (S41).
class InterviewDetail {
  const InterviewDetail({
    required this.id,
    required this.interviewType,
    required this.difficulty,
    required this.status,
    required this.role,
    required this.progress,
    required this.createdAt,
    required this.messages,
    required this.report,
    required this.feedback,
  });

  final String id;
  final String interviewType;
  final String difficulty;
  final SessionStatus status;
  final String? role;
  final InterviewProgress progress;
  final DateTime createdAt;
  final List<InterviewMessage> messages;
  final InterviewReport? report;

  /// 내가 남긴 리포트 만족도 (없으면 null)
  final SessionFeedback? feedback;
}
