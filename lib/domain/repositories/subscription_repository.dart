import '../entities/entitlement.dart';

abstract interface class SubscriptionRepository {
  /// `GET /subscriptions/me`
  Future<Entitlement> getEntitlement();

  /// `POST /subscriptions/verify` — 스토어 영수증을 서버가 검증하고 이용권을 준다.
  /// 멱등하므로 재시도해도 안전하다.
  Future<Entitlement> verify({
    required String platform,
    required String receipt,
    required String productId,
  });

  /// `POST /subscriptions/restore` — 기기 변경·재설치 후 복원 (애플 심사 필수 항목).
  Future<Entitlement> restore({
    required String platform,
    required String receipt,
    required String productId,
  });
}
