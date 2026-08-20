// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entitlement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EntitlementModel _$EntitlementModelFromJson(Map<String, dynamic> json) =>
    _EntitlementModel(
      plan: json['plan'] as String,
      isPro: json['isPro'] as bool,
      autoRenewing: json['autoRenewing'] as bool,
      freeInterviewsUsed: (json['freeInterviewsUsed'] as num).toInt(),
      freeInterviewsRemaining: (json['freeInterviewsRemaining'] as num).toInt(),
      expiresAt: json['expiresAt'] as String?,
    );

Map<String, dynamic> _$EntitlementModelToJson(_EntitlementModel instance) =>
    <String, dynamic>{
      'plan': instance.plan,
      'isPro': instance.isPro,
      'autoRenewing': instance.autoRenewing,
      'freeInterviewsUsed': instance.freeInterviewsUsed,
      'freeInterviewsRemaining': instance.freeInterviewsRemaining,
      'expiresAt': instance.expiresAt,
    };
