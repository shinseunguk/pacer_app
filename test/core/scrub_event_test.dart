import 'package:flutter_test/flutter_test.dart';
import 'package:pacer_app/core/observability/scrub_event.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// 사용자가 실제로 입력하는 민감 원문 — 하나라도 새어나가면 안 된다.
const _resume = '3년간 결제 서버를 담당하며 응답 지연을 40% 줄였습니다.';
const _answer = '캐시 무효화는 TTL과 이벤트 기반을 함께 썼습니다.';

/// 직렬화한 이벤트 전체에서 문자열을 찾는다 — 어느 경로로 새든 잡힌다.
bool _contains(SentryEvent? event, String needle) =>
    event.toString().contains(needle) ||
    event!.request.toString().contains(needle);

void main() {
  final hint = Hint();

  group('scrubEvent', () {
    test('요청 본문을 통째로 버린다', () {
      final event = SentryEvent(
        request: SentryRequest(
          url: 'https://api.pacer.app/v1/interviews',
          data: const {'applicantInfo': _resume, 'content': _answer},
        ),
      );

      final scrubbed = scrubEvent(event, hint);

      expect(scrubbed!.request!.data, '[redacted]');
      expect(_contains(scrubbed, _resume), isFalse);
      expect(_contains(scrubbed, _answer), isFalse);
    });

    test('화면이 늘어 새 필드가 생겨도 안전하다 (필드 목록에 의존하지 않는다)', () {
      final event = SentryEvent(
        request: SentryRequest(data: const {'someFutureField': _resume}),
      );

      expect(_contains(scrubEvent(event, hint), _resume), isFalse);
    });

    test('URL의 쿼리스트링을 잘라낸다', () {
      final event = SentryEvent(
        request: SentryRequest(
          url: 'https://api.pacer.app/v1/interviews?q=$_resume',
          queryString: 'q=$_resume',
        ),
      );

      final scrubbed = scrubEvent(event, hint);

      expect(scrubbed!.request!.url, 'https://api.pacer.app/v1/interviews');
      expect(scrubbed.request!.queryString, '[redacted]');
    });

    test('인증 헤더와 쿠키를 남기지 않는다', () {
      final event = SentryEvent(
        request: SentryRequest(
          headers: const {
            'authorization': 'Bearer secret-token',
            'cookie': 'session=abc',
            'content-type': 'application/json',
          },
          cookies: 'session=abc',
        ),
      );

      final scrubbed = scrubEvent(event, hint);

      expect(scrubbed!.request!.headers, {'content-type': 'application/json'});
      expect(scrubbed.request!.cookies, isNull);
      expect(_contains(scrubbed, 'secret-token'), isFalse);
    });

    test('헤더 이름의 대소문자와 무관하게 걸러낸다', () {
      final event = SentryEvent(
        request: SentryRequest(
          headers: const {'Authorization': 'Bearer x', 'Content-Type': 'a/b'},
        ),
      );

      expect(scrubEvent(event, hint)!.request!.headers, {'Content-Type': 'a/b'});
    });

    test('사용자는 내부 id만 남기고 이메일·닉네임은 버린다', () {
      final event = SentryEvent(
        user: SentryUser(id: 'user-1', email: 'me@test.com', username: '승욱'),
      );

      final user = scrubEvent(event, hint)!.user!;

      expect(user.id, 'user-1');
      expect(user.email, isNull);
      expect(user.username, isNull);
    });

    test('id 없이 이메일·닉네임만 있어도 지운다', () {
      final event = SentryEvent(
        user: SentryUser(email: 'me@test.com', username: '승욱'),
      );

      final user = scrubEvent(event, hint)!.user!;

      expect(user.email, isNull);
      expect(user.username, isNull);
      // SentryUser는 식별 필드가 최소 하나 필요하다 — 마스킹 값으로 채운다.
      expect(user.id, '[redacted]');
    });

    test('사용자가 없으면 만들어 내지 않는다', () {
      expect(scrubEvent(SentryEvent(), hint)!.user, isNull);
    });

    test('request가 없는 이벤트도 처리한다', () {
      expect(() => scrubEvent(SentryEvent(), hint), returnsNormally);
    });
  });

  group('scrubBreadcrumb', () {
    test('본문은 버리고 상태코드·메서드만 남긴다', () {
      final crumb = Breadcrumb(
        message: 'POST /interviews',
        data: const {'body': _answer, 'status_code': 200, 'method': 'POST'},
      );

      final scrubbed = scrubBreadcrumb(crumb, hint)!;

      expect(scrubbed.data, {'status_code': 200, 'method': 'POST'});
      expect(scrubbed.data.toString().contains(_answer), isFalse);
    });

    test('메시지에 붙은 쿼리스트링을 잘라낸다', () {
      final crumb = Breadcrumb(message: '/interviews?q=$_resume');

      expect(scrubBreadcrumb(crumb, hint)!.message, '/interviews');
    });

    test('남길 데이터가 없으면 null로 만든다', () {
      final crumb = Breadcrumb(data: const {'body': _answer});

      expect(scrubBreadcrumb(crumb, hint)!.data, isNull);
    });
  });
}
