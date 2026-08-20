import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/entitlement.dart';

part 'entitlement_model.freezed.dart';
part 'entitlement_model.g.dart';

/// `GET /subscriptions/me` · `POST /subscriptions/verify` 응답.
@freezed
abstract class EntitlementModel with _$EntitlementModel {
  const EntitlementModel._();

  const factory EntitlementModel({
    required String plan,
    required bool isPro,
    required bool autoRenewing,
    required int freeInterviewsUsed,
    required int freeInterviewsRemaining,
    String? expiresAt,
  }) = _EntitlementModel;

  factory EntitlementModel.fromJson(Map<String, dynamic> json) =>
      _$EntitlementModelFromJson(json);

  Entitlement toEntity() => Entitlement(
    plan: SubscriptionPlan.fromValue(plan),
    isPro: isPro,
    expiresAt: expiresAt == null ? null : DateTime.tryParse(expiresAt!),
    autoRenewing: autoRenewing,
    freeInterviewsUsed: freeInterviewsUsed,
    freeInterviewsRemaining: freeInterviewsRemaining,
  );
}
