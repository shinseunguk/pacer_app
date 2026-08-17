// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UsageSummaryModel _$UsageSummaryModelFromJson(Map<String, dynamic> json) =>
    _UsageSummaryModel(
      date: json['date'] as String,
      baseQuestionUsed: (json['baseQuestionUsed'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      remaining: (json['remaining'] as num).toInt(),
    );

Map<String, dynamic> _$UsageSummaryModelToJson(_UsageSummaryModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'baseQuestionUsed': instance.baseQuestionUsed,
      'limit': instance.limit,
      'remaining': instance.remaining,
    };

_UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    _UserProfileModel(
      id: json['id'] as String,
      nickname: json['nickname'] as String,
      email: json['email'] as String?,
      isPro: json['isPro'] as bool? ?? false,
      usage: UsageSummaryModel.fromJson(json['usage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserProfileModelToJson(_UserProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'email': instance.email,
      'isPro': instance.isPro,
      'usage': instance.usage,
    };
