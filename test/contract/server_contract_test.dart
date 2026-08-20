@Tags(['contract'])
library;

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pacer_app/data/datasources/auth_remote_data_source.dart';
import 'package:pacer_app/data/datasources/interview_remote_data_source.dart';
import 'package:pacer_app/data/datasources/job_remote_data_source.dart';
import 'package:pacer_app/data/datasources/legal_remote_data_source.dart';
import 'package:pacer_app/data/datasources/user_remote_data_source.dart';
import 'package:pacer_app/data/repositories/interview_repository_impl.dart';
import 'package:pacer_app/data/repositories/legal_repository_impl.dart';
import 'package:pacer_app/domain/entities/agreements.dart';
import 'package:pacer_app/domain/entities/interview_message.dart';
import 'package:pacer_app/domain/entities/interview_report.dart';
import 'package:pacer_app/domain/entities/interview_setup.dart';
import 'package:pacer_app/domain/entities/interview_turn_event.dart';
import 'package:pacer_app/domain/entities/legal_document.dart';
import 'package:pacer_app/domain/entities/social_provider.dart';
import 'package:pacer_app/domain/validation/nickname_rule.dart';

/// 실서버 계약 검증 — 앱의 DTO·경로·SSE 파싱이 pacer_server와 맞는지 확인한다.
///
/// 기본 `flutter test`에서는 건너뛴다. 서버를 띄운 뒤 아래처럼 실행한다:
/// ```
/// (pacer_server) docker compose up -d && npm run start:dev
/// (pacer_app)    PACER_SERVER_E2E=1 flutter test test/contract
/// ```
void main() {
  final enabled = Platform.environment['PACER_SERVER_E2E'] == '1';
  final baseUrl =
      Platform.environment['PACER_API_BASE_URL'] ?? 'http://localhost:3000/v1';

  group(
    '서버 계약',
    () {
      late Dio dio;
      late AuthRemoteDataSource auth;
      late UserRemoteDataSource users;
      late JobRemoteDataSource jobs;
      late InterviewRemoteDataSource interviews;
      late InterviewRepositoryImpl repository;
      String? token;
      // 닉네임은 유니크 제약이 있으므로 실행마다 다른 값을 쓴다.
      final myNickname = '계약${DateTime.now().millisecondsSinceEpoch % 100000}';

      setUpAll(() async {
        dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 30),
            contentType: Headers.jsonContentType,
            validateStatus: (status) => status != null && status < 400,
          ),
        );
        dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              if (token != null) {
                options.headers['Authorization'] = 'Bearer $token';
              }
              handler.next(options);
            },
          ),
        );

        auth = AuthRemoteDataSource(dio);
        users = UserRemoteDataSource(dio);
        jobs = JobRemoteDataSource(dio);
        interviews = InterviewRemoteDataSource(dio);
        repository = InterviewRepositoryImpl(interviews);

        final session = await auth.login(
          SocialProvider.kakao,
          'contract-${DateTime.now().microsecondsSinceEpoch}',
        );
        token = session.accessToken;

        await users.onboarding(
          nickname: myNickname,
          agreements: const Agreements(
            terms: true,
            privacy: true,
            llmConsent: true,
          ),
        );
      });

      test('프로필·사용량 응답을 파싱한다', () async {
        final profile = (await users.getMe()).toEntity();

        expect(profile.nickname, myNickname);
        expect(profile.usage.limit, greaterThan(0));
      });

      test('약관·처리방침을 인증 없이 파싱한다', () async {
        final privacy = await LegalRepositoryImpl(
          LegalRemoteDataSource(dio),
        ).getDocument(LegalDocumentType.privacy);

        expect(privacy.title, isNotEmpty);
        expect(privacy.version, isNotEmpty);
        expect(privacy.sections, isNotEmpty);
      });

      test('닉네임 중복 확인이 계약대로 동작한다', () async {
        final mine = '중복${DateTime.now().microsecondsSinceEpoch % 100000}';

        // 아직 아무도 안 쓰는 닉네임 → 사용 가능
        await expectLater(users.isNicknameAvailable(mine), completion(isTrue));

        // 내가 쓰면 → 다른 사람에겐 불가
        await users.onboarding(
          nickname: mine,
          agreements: const Agreements(
            terms: true,
            privacy: true,
            llmConsent: true,
          ),
        );

        final otherSession = await auth.login(
          SocialProvider.kakao,
          'contract-other-${DateTime.now().microsecondsSinceEpoch}',
        );
        final previous = token;
        token = otherSession.accessToken;
        await expectLater(users.isNicknameAvailable(mine), completion(isFalse));

        // 선점된 닉네임으로 온보딩하면 409
        await expectLater(
          users.onboarding(
            nickname: mine,
            agreements: const Agreements(
              terms: true,
              privacy: true,
              llmConsent: true,
            ),
          ),
          throwsA(
            isA<DioException>().having(
              (e) => e.response?.statusCode,
              'statusCode',
              409,
            ),
          ),
        );
        token = previous;
      });

      test('앱이 막는 닉네임은 서버도 422로 막는다', () async {
        for (final bad in ['ㅋㅋ', '승욱!', '신 승욱', '김']) {
          // 앱 규칙에서 이미 걸러진다.
          expect(isValidNickname(bad), isFalse, reason: bad);

          await expectLater(
            users.onboarding(
              nickname: bad,
              agreements: const Agreements(
                terms: true,
                privacy: true,
                llmConsent: true,
              ),
            ),
            throwsA(
              isA<DioException>().having(
                (e) => e.response?.statusCode,
                'statusCode',
                422,
              ),
            ),
            reason: bad,
          );
        }
      });

      test('직무 트리를 파싱한다', () async {
        final categories = await jobs.getCategories();

        expect(categories, isNotEmpty);
        expect(categories.first.roles, isNotEmpty);
      });

      test('면접 생성 → SSE 답변 → 스킵 → 종료 → 재열람이 계약대로 동작한다', () async {
        const setup = InterviewSetup(
          jobSource: JobSource.paste,
          jobPostingText: '주요 업무: 결제 서버 API 개발',
          applicantInfo: '경력 3년 백엔드',
          questionCount: kMinQuestionCount,
        );

        final created = await repository.create(setup);
        expect(created.progress.total, kMinQuestionCount);
        // 첫 질문은 자기소개(도입) — 문항 수에 포함되지 않으므로 진행도는 0이다.
        expect(created.firstQuestion.type, MessageType.introQuestion);
        expect(created.progress.current, 0);
        expect(created.firstQuestion.content, isNotEmpty);

        final events = await repository
            .submitAnswer(created.sessionId, '결제 서버를 3년 맡아온 백엔드 개발자입니다.')
            .toList();
        expect(events.whereType<TurnDelta>(), isNotEmpty);
        expect(events.last, isA<TurnDone>());

        // 도입 질문 2개(자기소개·지원동기)를 지나야 직무 질문 1번이 시작된다.
        final afterIntro = await repository.skip(created.sessionId);
        expect(afterIntro.progress.current, 1);

        final answered = await repository
            .submitAnswer(created.sessionId, '결제 API의 응답 지연을 40% 줄인 경험이 있습니다.')
            .toList();
        expect(answered.last, isA<TurnDone>());

        final skipped = await repository.skip(created.sessionId);
        expect(skipped.progress.total, kMinQuestionCount);

        final report = await repository.complete(created.sessionId);
        expect(report.overallScore, inInclusiveRange(0, 100));
        expect(report.scores, hasLength(4));

        final detail = await repository.getDetail(created.sessionId);
        expect(detail.messages, isNotEmpty);
        expect(detail.report?.overallScore, report.overallScore);

        // 리포트 만족도 — MVP 성공 기준 §6 지표 수집
        final feedback = await repository.submitFeedback(
          created.sessionId,
          rating: FeedbackRating.down,
          comment: '점수 근거가 약해요',
        );
        expect(feedback.rating, FeedbackRating.down);

        final withFeedback = await repository.getDetail(created.sessionId);
        expect(withFeedback.feedback?.rating, FeedbackRating.down);
        expect(withFeedback.feedback?.comment, '점수 근거가 약해요');

        final history = await repository.getHistory(limit: 5);
        expect(
          history.items.map((item) => item.id),
          contains(created.sessionId),
        );
      });
    },
    skip: enabled ? false : '서버 계약 테스트는 PACER_SERVER_E2E=1 일 때만 실행합니다.',
  );
}
