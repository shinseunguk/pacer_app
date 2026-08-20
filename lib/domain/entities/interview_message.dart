/// 발화 종류 (ERD: interview_messages.type).
enum MessageType {
  /// 자기소개·지원동기. 문항 수·진행도·평가에서 빠지는 워밍업이다 (ADR 0006).
  introQuestion('intro_question'),
  baseQuestion('base_question'),
  followUp('follow_up'),
  answer('answer'),
  skip('skip');

  const MessageType(this.value);

  final String value;

  static MessageType fromValue(String value) {
    return MessageType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => MessageType.baseQuestion,
    );
  }

  bool get isInterviewer =>
      this == MessageType.introQuestion ||
      this == MessageType.baseQuestion ||
      this == MessageType.followUp;
}

/// 질문별 피드백·모범답안 (대화 전문 재열람에서 노출).
class MessageFeedback {
  const MessageFeedback({this.feedback, this.modelAnswer});

  final String? feedback;
  final String? modelAnswer;
}

class InterviewMessage {
  const InterviewMessage({
    required this.messageId,
    required this.seq,
    required this.type,
    required this.content,
    this.parentId,
    this.feedback,
  });

  final String messageId;
  final int seq;
  final MessageType type;
  final String? content;
  final String? parentId;
  final MessageFeedback? feedback;

  InterviewMessage copyWith({String? content, MessageFeedback? feedback}) {
    return InterviewMessage(
      messageId: messageId,
      seq: seq,
      type: type,
      content: content ?? this.content,
      parentId: parentId,
      feedback: feedback ?? this.feedback,
    );
  }
}

/// 질문 진행도 (n/N).
class InterviewProgress {
  const InterviewProgress({required this.current, required this.total});

  final int current;
  final int total;
}
