import 'package:flutter_test/flutter_test.dart';
import 'package:pacer_app/domain/entities/entitlement.dart';

Entitlement free({int remaining = kFreeInterviewLimit}) => Entitlement(
  plan: SubscriptionPlan.free,
  isPro: false,
  expiresAt: null,
  autoRenewing: false,
  freeInterviewsUsed: kFreeInterviewLimit - remaining,
  freeInterviewsRemaining: remaining,
);

const pro = Entitlement(
  plan: SubscriptionPlan.pro,
  isPro: true,
  expiresAt: null,
  autoRenewing: true,
  freeInterviewsUsed: 0,
  freeInterviewsRemaining: 0,
);

void main() {
  test('서버 응답 전에는 무료로 가정한다', () {
    // pro로 가정하면 잠금이 풀린 화면을 잠깐 보여주게 된다.
    const unknown = Entitlement.unknown();

    expect(unknown.isPro, isFalse);
    expect(unknown.freeInterviewsRemaining, kFreeInterviewLimit);
  });

  group('마지막 1회 예고', () {
    test('무료가 하나 남았을 때만 예고한다', () {
      expect(free(remaining: 1).isLastFreeInterview, isTrue);
    });

    test('2회 남았으면 예고하지 않는다 — 매번 띄우면 잔소리다', () {
      expect(free(remaining: 2).isLastFreeInterview, isFalse);
    });

    test('다 썼으면 예고가 아니라 페이월이다', () {
      expect(free(remaining: 0).isLastFreeInterview, isFalse);
      expect(free(remaining: 0).hasExhaustedFreeInterviews, isTrue);
    });

    test('구독자에게는 예고하지 않는다', () {
      expect(pro.isLastFreeInterview, isFalse);
      expect(pro.hasExhaustedFreeInterviews, isFalse);
    });
  });

  group('문항 수 잠금', () {
    test('무료는 5문항까지만 고를 수 있다', () {
      final entitlement = free();

      expect(entitlement.canUseQuestionCount(5), isTrue);
      expect(entitlement.canUseQuestionCount(10), isFalse);
      expect(entitlement.canUseQuestionCount(15), isFalse);
    });

    test('구독자는 전부 고를 수 있다', () {
      expect(pro.canUseQuestionCount(15), isTrue);
    });

    test('무료 잔여 횟수와 무관하게 문항 수 제한은 그대로다', () {
      // 잔여가 남아 있어도 10문항은 못 고른다 — 다른 축이다.
      expect(free(remaining: 2).canUseQuestionCount(10), isFalse);
    });
  });
}
