import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/entitlement.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../providers/app_providers.dart';

/// 이용권 상태. 홈 스트립·프리셋 잠금·리포트 CTA·페이월이 모두 이 값을 본다.
final entitlementProvider =
    AsyncNotifierProvider<EntitlementNotifier, Entitlement>(
      EntitlementNotifier.new,
    );

class EntitlementNotifier extends AsyncNotifier<Entitlement> {
  SubscriptionRepository get _repository =>
      ref.read(subscriptionRepositoryProvider);

  @override
  Future<Entitlement> build() => _repository.getEntitlement();

  /// 구매 → 영수증 서버 검증 → 이용권 반영.
  ///
  /// 사용자가 결제 창을 닫으면 [PurchaseCancelled]를 그대로 올려보낸다.
  /// 화면이 오류로 표시하지 않게 하려면 호출부가 이 타입을 구분해야 한다.
  Future<void> purchase() async {
    final previous = state;
    state = const AsyncValue.loading();

    try {
      final receipt = await ref.read(storePurchaseServiceProvider).buy(kProMonthlySku);
      final entitlement = await _repository.verify(
        platform: receipt.platform,
        receipt: receipt.receipt,
        productId: kProMonthlySku,
      );
      state = AsyncValue.data(entitlement);
    } on PurchaseCancelled {
      // 취소는 오류가 아니다 — 직전 상태로 되돌리고 조용히 끝낸다.
      state = previous;
      rethrow;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  /// 복원. 복원할 구매가 없으면 상태를 바꾸지 않고 false.
  Future<bool> restore() async {
    final receipt = await ref
        .read(storePurchaseServiceProvider)
        .restore(kProMonthlySku);
    if (receipt == null) return false;

    final entitlement = await _repository.restore(
      platform: receipt.platform,
      receipt: receipt.receipt,
      productId: kProMonthlySku,
    );
    state = AsyncValue.data(entitlement);
    return entitlement.isPro;
  }

  /// 면접을 마친 뒤 등 잔여 횟수가 달라졌을 때 다시 읽는다.
  Future<void> refresh() async {
    state = await AsyncValue.guard(_repository.getEntitlement);
  }
}
