import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pacer_app/core/error/failure.dart';
import 'package:pacer_app/domain/entities/interview_message.dart';
import 'package:pacer_app/domain/entities/interview_session.dart';
import 'package:pacer_app/domain/entities/interview_turn_event.dart';
import 'package:pacer_app/domain/repositories/interview_repository.dart';
import 'package:pacer_app/presentation/interview/session/interview_session_notifier.dart';
import 'package:pacer_app/presentation/providers/interview_providers.dart';

class _MockInterviewRepository extends Mock implements InterviewRepository {}

const _sessionId = 'session-1';

InterviewMessage _question(int seq, String content) => InterviewMessage(
  messageId: 'q$seq',
  seq: seq,
  type: MessageType.baseQuestion,
  content: content,
);

InterviewDetail _detail({
  int current = 1,
  int total = 3,
  SessionStatus status = SessionStatus.inProgress,
}) {
  return InterviewDetail(
    id: _sessionId,
    interviewType: 'general',
    difficulty: 'mid',
    status: status,
    role: '백엔드',
    progress: InterviewProgress(current: current, total: total),
    createdAt: DateTime.utc(2026, 8, 15),
    messages: [_question(1, '자기소개 부탁드립니다.')],
    report: null,
    feedback: null,
  );
}

void main() {
  late _MockInterviewRepository repository;

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [interviewRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    return container;
  }

  setUp(() {
    repository = _MockInterviewRepository();
    when(
      () => repository.getDetail(any()),
    ).thenAnswer((_) async => _detail());
  });

  test('진입하면 서버의 대화·진행도를 그대로 싣는다', () async {
    final container = createContainer();

    final state = await container.read(
      interviewSessionProvider(_sessionId).future,
    );

    expect(state.messages, hasLength(1));
    expect(state.progress.current, 1);
    expect(state.status, SessionStatus.inProgress);
    expect(state.canAnswer, isTrue);
  });

  group('답변 전송', () {
    test('델타를 이어붙여 다음 질문을 만들고 진행도를 갱신한다', () async {
      when(() => repository.submitAnswer(any(), any())).thenAnswer(
        (_) => Stream.fromIterable([
          const TurnDelta(
            messageId: 'q2',
            type: MessageType.baseQuestion,
            delta: '가장 어려웠던 ',
          ),
          const TurnDelta(
            messageId: 'q2',
            type: MessageType.baseQuestion,
            delta: '문제는 무엇인가요?',
          ),
          const TurnDone(
            messageId: 'q2',
            seq: 3,
            type: MessageType.baseQuestion,
            progress: InterviewProgress(current: 2, total: 3),
          ),
        ]),
      );

      final container = createContainer();
      final provider = interviewSessionProvider(_sessionId);
      await container.read(provider.future);

      await container.read(provider.notifier).sendAnswer('3년차 백엔드입니다.');

      final state = container.read(provider).requireValue;
      expect(state.messages.map((m) => m.type), [
        MessageType.baseQuestion,
        MessageType.answer,
        MessageType.baseQuestion,
      ]);
      expect(state.messages.last.content, '가장 어려웠던 문제는 무엇인가요?');
      expect(state.messages.last.seq, 3);
      expect(state.progress.current, 2);
      expect(state.isStreaming, isFalse);
      expect(state.turnError, isNull);
    });

    test('마지막 질문까지 끝나면 종료 상태가 되어 입력을 막는다', () async {
      when(() => repository.submitAnswer(any(), any())).thenAnswer(
        (_) => Stream.fromIterable([const InterviewFinished(_sessionId)]),
      );

      final container = createContainer();
      final provider = interviewSessionProvider(_sessionId);
      await container.read(provider.future);

      await container.read(provider.notifier).sendAnswer('마지막 답변입니다.');

      final state = container.read(provider).requireValue;
      expect(state.isFinished, isTrue);
      expect(state.canAnswer, isFalse);
    });

    test('전송이 실패하면 답변은 남기고 오류만 표시한다', () async {
      when(
        () => repository.submitAnswer(any(), any()),
      ).thenAnswer((_) => Stream.error(const NetworkFailure()));

      final container = createContainer();
      final provider = interviewSessionProvider(_sessionId);
      await container.read(provider.future);

      await container.read(provider.notifier).sendAnswer('답변입니다.');

      final state = container.read(provider).requireValue;
      expect(state.turnError, isA<NetworkFailure>());
      expect(state.isStreaming, isFalse);
      expect(state.messages.last.type, MessageType.answer);
    });

    test('스트리밍 중에는 중복 전송하지 않는다', () async {
      when(() => repository.submitAnswer(any(), any())).thenAnswer(
        (_) => Stream.fromIterable([
          const TurnDelta(
            messageId: 'q2',
            type: MessageType.baseQuestion,
            delta: '다음 질문',
          ),
        ]),
      );

      final container = createContainer();
      final provider = interviewSessionProvider(_sessionId);
      await container.read(provider.future);

      final first = container.read(provider.notifier).sendAnswer('답변 1');
      await container.read(provider.notifier).sendAnswer('답변 2');
      await first;

      verify(() => repository.submitAnswer(_sessionId, '답변 1')).called(1);
      verifyNever(() => repository.submitAnswer(_sessionId, '답변 2'));
    });
  });

  group('스킵', () {
    test('미응답을 남기고 다음 질문을 붙인다', () async {
      when(() => repository.skip(any())).thenAnswer(
        (_) async => SkipResult(
          next: _question(3, '두 번째 질문입니다.'),
          progress: const InterviewProgress(current: 2, total: 3),
          done: false,
        ),
      );

      final container = createContainer();
      final provider = interviewSessionProvider(_sessionId);
      await container.read(provider.future);

      await container.read(provider.notifier).skip();

      final state = container.read(provider).requireValue;
      expect(state.messages.map((m) => m.type), [
        MessageType.baseQuestion,
        MessageType.skip,
        MessageType.baseQuestion,
      ]);
      expect(state.progress.current, 2);
      expect(state.isFinished, isFalse);
    });

    test('남은 질문이 없으면 종료 상태가 된다', () async {
      when(() => repository.skip(any())).thenAnswer(
        (_) async => const SkipResult(
          next: null,
          progress: InterviewProgress(current: 3, total: 3),
          done: true,
        ),
      );

      final container = createContainer();
      final provider = interviewSessionProvider(_sessionId);
      await container.read(provider.future);

      await container.read(provider.notifier).skip();

      final state = container.read(provider).requireValue;
      expect(state.isFinished, isTrue);
      expect(state.messages.last.type, MessageType.skip);
    });
  });

  test('일시정지하면 입력이 잠긴다', () async {
    when(() => repository.pause(any())).thenAnswer((_) async {});

    final container = createContainer();
    final provider = interviewSessionProvider(_sessionId);
    await container.read(provider.future);

    await container.read(provider.notifier).pause();

    final state = container.read(provider).requireValue;
    expect(state.status, SessionStatus.paused);
    expect(state.canAnswer, isFalse);
  });

  test('완료된 면접으로 들어가면 처음부터 종료 상태다', () async {
    when(() => repository.getDetail(any())).thenAnswer(
      (_) async => _detail(current: 3, status: SessionStatus.completed),
    );

    final container = createContainer();

    final state = await container.read(
      interviewSessionProvider(_sessionId).future,
    );

    expect(state.isFinished, isTrue);
    expect(state.canAnswer, isFalse);
  });
}
