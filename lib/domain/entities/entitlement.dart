/// 무료로 진행할 수 있는 면접 수 — 평생 누적이며 리셋되지 않는다.
/// 서버 `FREE_INTERVIEW_LIMIT`와 같은 값이어야 한다.
const kFreeInterviewLimit = 2;

/// 무료 사용자가 고를 수 있는 문항 수. 프리셋 '빠른 연습'과 같다.
const kFreeQuestionCount = 5;

/// 구독 상품 ID. 스토어와 서버 `products.sku`가 이 값으로 맞춰져 있다.
const kProMonthlySku = 'pro_monthly';

/// 월 구독가(원). 표시용이며 실제 과금은 스토어가 한다.
const kProMonthlyPriceKrw = 9900;

enum SubscriptionPlan {
  free,
  pro;

  static SubscriptionPlan fromValue(String value) {
    return SubscriptionPlan.values.firstWhere(
      (plan) => plan.name == value,
      orElse: () => SubscriptionPlan.free,
    );
  }
}

/// 지금 무엇을 쓸 수 있는지 (`GET /subscriptions/me`).
class Entitlement {
  const Entitlement({
    required this.plan,
    required this.isPro,
    required this.expiresAt,
    required this.autoRenewing,
    required this.freeInterviewsUsed,
    required this.freeInterviewsRemaining,
  });

  /// 서버 응답을 받기 전에 쓰는 보수적 기본값.
  /// pro로 가정하면 잠금이 풀린 화면을 잠깐 보여주게 되므로 free로 둔다.
  const Entitlement.unknown()
    : plan = SubscriptionPlan.free,
      isPro = false,
      expiresAt = null,
      autoRenewing = false,
      freeInterviewsUsed = 0,
      freeInterviewsRemaining = kFreeInterviewLimit;

  final SubscriptionPlan plan;
  final bool isPro;
  final DateTime? expiresAt;
  final bool autoRenewing;
  final int freeInterviewsUsed;
  final int freeInterviewsRemaining;

  bool get hasFreeInterviewsLeft => freeInterviewsRemaining > 0;

  /// 남은 무료 면접이 하나뿐 — 시작 직전에 한 번만 예고한다.
  /// 매번 띄우면 잔소리가 되고, 다 쓴 뒤에 알리면 늦다.
  bool get isLastFreeInterview => !isPro && freeInterviewsRemaining == 1;

  bool get hasExhaustedFreeInterviews => !isPro && freeInterviewsRemaining <= 0;

  /// 무료는 '빠른 연습'(5문항)만 고를 수 있다.
  bool canUseQuestionCount(int questionCount) {
    return isPro || questionCount <= kFreeQuestionCount;
  }
}
