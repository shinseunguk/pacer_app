import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/interview_message.dart';
import '../../../domain/entities/interview_session.dart';
import '../../../domain/entities/interview_turn_event.dart';
import '../../providers/interview_providers.dart';

/// S20 화면 상태 — 대화 + 진행도 + 스트리밍 여부.
class InterviewSessionState {
  const InterviewSessionState({
    required this.messages,
    required this.progress,
    required this.status,
    this.isStreaming = false,
    this.isFinished = false,
    this.turnError,
  });

  final List<InterviewMessage> messages;
  final InterviewProgress progress;
  final SessionStatus status;

  /// 면접관 발화를 받는 중(입력 잠금 + 타이핑 표시).
  final bool isStreaming;

  /// 마지막 질문까지 끝나 종료(리포트)로 넘어갈 수 있는 상태.
  final bool isFinished;

  /// 답변 전송 실패 — 입력은 유지하고 재시도를 안내한다.
  final Object? turnError;

  bool get canAnswer =>
      !isStreaming && !isFinished && status == SessionStatus.inProgress;

  InterviewSessionState copyWith({
    List<InterviewMessage>? messages,
    InterviewProgress? progress,
    SessionStatus? status,
    bool? isStreaming,
    bool? isFinished,
    Object? turnError,
    bool clearError = false,
  }) {
    return InterviewSessionState(
      messages: messages ?? this.messages,
      progress: progress ?? this.progress,
      status: status ?? this.status,
      isStreaming: isStreaming ?? this.isStreaming,
      isFinished: isFinished ?? this.isFinished,
      turnError: clearError ? null : (turnError ?? this.turnError),
    );
  }
}

final interviewSessionProvider = AsyncNotifierProvider.autoDispose
    .family<InterviewSessionNotifier, InterviewSessionState, String>(
      InterviewSessionNotifier.new,
    );

class InterviewSessionNotifier
    extends AutoDisposeFamilyAsyncNotifier<InterviewSessionState, String> {
  @override
  Future<InterviewSessionState> build(String sessionId) async {
    // 새 면접·이어하기 모두 서버 상태를 원본으로 삼는다(재진입·복구 안전).
    final detail = await ref.watch(getInterviewDetailProvider)(sessionId);

    return InterviewSessionState(
      messages: detail.messages,
      progress: detail.progress,
      status: detail.status,
      isFinished:
          detail.status == SessionStatus.completed ||
          detail.progress.current >= detail.progress.total,
    );
  }

  /// 답변 전송 → SSE로 다음 발화를 받아 대화에 흘려 넣는다.
  Future<void> sendAnswer(String content) async {
    final current = state.valueOrNull;
    if (current == null || !current.canAnswer) return;

    final answered = current.copyWith(
      messages: [
        ...current.messages,
        InterviewMessage(
          messageId: 'local-${current.messages.length + 1}',
          seq: _nextSeq(current.messages),
          type: MessageType.answer,
          content: content,
        ),
      ],
      isStreaming: true,
      clearError: true,
    );
    state = AsyncData(answered);

    try {
      await for (final event in ref.read(submitAnswerProvider)(arg, content)) {
        _apply(event);
      }
      _stopStreaming();
    } on Object catch (error) {
      _stopStreaming(error: error);
    }
  }

  /// "모르겠습니다" — 미응답으로 넘기고 다음 질문을 받는다.
  Future<void> skip() async {
    final current = state.valueOrNull;
    if (current == null || !current.canAnswer) return;

    state = AsyncData(current.copyWith(isStreaming: true, clearError: true));

    try {
      final result = await ref.read(skipQuestionProvider)(arg);
      final base = state.valueOrNull ?? current;

      state = AsyncData(
        base.copyWith(
          messages: [
            ...base.messages,
            InterviewMessage(
              messageId: 'local-skip-${base.messages.length + 1}',
              seq: _nextSeq(base.messages),
              type: MessageType.skip,
              content: null,
            ),
            if (result.next != null) result.next!,
          ],
          progress: result.progress,
          isStreaming: false,
          isFinished: result.done,
        ),
      );
    } on Object catch (error) {
      _stopStreaming(error: error);
    }
  }

  Future<void> pause() async {
    final current = state.valueOrNull;
    if (current == null) return;

    await ref.read(pauseInterviewProvider)(arg);
    state = AsyncData(current.copyWith(status: SessionStatus.paused));
  }

  Future<void> resume() async {
    await ref.read(resumeInterviewProvider)(arg);
    // 중단 지점 컨텍스트는 일부 발화만 오므로 전체 대화를 다시 읽는다.
    ref.invalidate(getInterviewDetailProvider);
    ref.invalidateSelf();
  }

  void _apply(InterviewTurnEvent event) {
    final current = state.valueOrNull;
    if (current == null) return;

    switch (event) {
      case TurnDelta(:final messageId, :final type, :final delta):
        state = AsyncData(
          current.copyWith(
            messages: _appendDelta(current.messages, messageId, type, delta),
          ),
        );
      case TurnDone(:final messageId, :final seq, :final progress):
        state = AsyncData(
          current.copyWith(
            messages: _finalize(current.messages, messageId, seq),
            progress: progress,
          ),
        );
      case InterviewFinished():
        state = AsyncData(current.copyWith(isFinished: true));
      case TurnError():
        state = AsyncData(current.copyWith(turnError: event));
    }
  }

  void _stopStreaming({Object? error}) {
    final current = state.valueOrNull;
    if (current == null) return;

    state = AsyncData(
      current.copyWith(
        isStreaming: false,
        turnError: error,
        clearError: error == null,
      ),
    );
  }

  List<InterviewMessage> _appendDelta(
    List<InterviewMessage> messages,
    String messageId,
    MessageType type,
    String delta,
  ) {
    final index = messages.indexWhere(
      (message) => message.messageId == messageId,
    );

    if (index == -1) {
      return [
        ...messages,
        InterviewMessage(
          messageId: messageId,
          seq: _nextSeq(messages),
          type: type,
          content: delta,
        ),
      ];
    }

    final updated = [...messages];
    final target = updated[index];
    updated[index] = target.copyWith(content: '${target.content ?? ''}$delta');
    return updated;
  }

  List<InterviewMessage> _finalize(
    List<InterviewMessage> messages,
    String messageId,
    int seq,
  ) {
    final index = messages.indexWhere(
      (message) => message.messageId == messageId,
    );
    if (index == -1) return messages;

    final updated = [...messages];
    final target = updated[index];
    updated[index] = InterviewMessage(
      messageId: target.messageId,
      seq: seq,
      type: target.type,
      content: target.content,
      parentId: target.parentId,
      feedback: target.feedback,
    );
    return updated;
  }

  int _nextSeq(List<InterviewMessage> messages) {
    return messages.fold<int>(0, (max, m) => m.seq > max ? m.seq : max) + 1;
  }
}
