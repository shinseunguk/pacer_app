import 'dart:io';

import '../../core/error/failure.dart';

/// 스토어 결제가 돌려준 영수증. 서버가 검증한다.
class StoreReceipt {
  const StoreReceipt({required this.platform, required this.receipt});

  /// 서버 `PURCHASE_PLATFORMS`와 같은 값 — apple / google / stub.
  final String platform;
  final String receipt;
}

/// 스토어 결제의 포트.
///
/// 실제 어댑터(`in_app_purchase`)는 **스토어에 상품이 등록돼야** 동작한다.
/// 애플·구글 개발자 계정이 없는 동안에도 페이월→구매→이용권 전 구간을 돌리기 위해
/// 포트를 먼저 둔다 (서버 `ReceiptVerifier`와 같은 패턴).
abstract interface class StorePurchaseService {
  /// 구독 구매. 사용자가 취소하면 [PurchaseCancelled]를 던진다.
  Future<StoreReceipt> buy(String productId);

  /// 기기 변경·재설치 후 복원. 복원할 구매가 없으면 null.
  Future<StoreReceipt?> restore(String productId);
}

/// 스토어 상품 등록 전에 쓰는 개발용 구현.
///
/// 서버의 `StubReceiptVerifier`와 짝을 이룬다 (`stub:<거래ID>` 형식).
/// 운영 빌드에서는 [UnavailableStorePurchaseService]가 대신 주입된다.
class StubStorePurchaseService implements StorePurchaseService {
  const StubStorePurchaseService({this.accountId = 'local'});

  /// 같은 값을 쓰면 서버가 같은 거래로 보고 이용권을 중복 부여하지 않는다.
  /// 멱등성을 로컬에서 확인할 수 있게 고정값을 쓴다.
  final String accountId;

  @override
  Future<StoreReceipt> buy(String productId) async {
    return StoreReceipt(
      platform: 'stub',
      receipt: 'stub:$productId-$accountId',
    );
  }

  @override
  Future<StoreReceipt?> restore(String productId) => buy(productId);
}

/// 스토어를 쓸 수 없는 빌드. 결제 버튼을 눌러도 명확한 안내로 끝난다.
class UnavailableStorePurchaseService implements StorePurchaseService {
  const UnavailableStorePurchaseService();

  @override
  Future<StoreReceipt> buy(String productId) {
    throw const UnknownFailure('지금은 구매할 수 없어요. 잠시 후 다시 시도해주세요.');
  }

  @override
  Future<StoreReceipt?> restore(String productId) async => null;
}

/// 현재 기기의 스토어 플랫폼 값 (서버 `PURCHASE_PLATFORMS`와 같은 문자열).
String currentStorePlatform() => Platform.isIOS ? 'apple' : 'google';
