import 'interview_message.dart';

/// `POST /interviews/{id}/answer` SSE 이벤트 (API 명세 §8).
sealed class InterviewTurnEvent {
  const InterviewTurnEvent();
}

/// 다음 질문/꼬리질문의 토큰 조각.
class TurnDelta extends InterviewTurnEvent {
  const TurnDelta({
    required this.messageId,
    required this.type,
    required this.delta,
  });

  final String messageId;
  final MessageType type;
  final String delta;
}

/// 발화 완료 — 최종 seq·진행도 확정.
class TurnDone extends InterviewTurnEvent {
  const TurnDone({
    required this.messageId,
    required this.seq,
    required this.type,
    required this.progress,
    this.parentId,
  });

  final String messageId;
  final int seq;
  final MessageType type;
  final InterviewProgress progress;
  final String? parentId;
}

/// 마지막 질문까지 끝 → complete 유도.
class InterviewFinished extends InterviewTurnEvent {
  const InterviewFinished(this.sessionId);

  final String sessionId;
}

/// 스트림 도중 발생한 오류.
class TurnError extends InterviewTurnEvent {
  const TurnError({required this.code, required this.message});

  final String code;
  final String message;
}
