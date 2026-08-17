import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/usage_summary.dart';
import '../../domain/entities/user_profile.dart';

part 'user_profile_model.freezed.dart';
part 'user_profile_model.g.dart';

/// `GET /users/me` → usage block.
@freezed
abstract class UsageSummaryModel with _$UsageSummaryModel {
  const UsageSummaryModel._();

  const factory UsageSummaryModel({
    required String date,
    required int baseQuestionUsed,
    required int limit,
    required int remaining,
  }) = _UsageSummaryModel;

  factory UsageSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$UsageSummaryModelFromJson(json);

  UsageSummary toEntity() => UsageSummary(
    date: date,
    baseQuestionUsed: baseQuestionUsed,
    limit: limit,
    remaining: remaining,
  );
}

/// `GET /users/me` response.
@freezed
abstract class UserProfileModel with _$UserProfileModel {
  const UserProfileModel._();

  const factory UserProfileModel({
    required String id,
    required String nickname,
    String? email,
    @Default(false) bool isPro,
    required UsageSummaryModel usage,
  }) = _UserProfileModel;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  UserProfile toEntity() => UserProfile(
    id: id,
    nickname: nickname,
    email: email,
    isPro: isPro,
    usage: usage.toEntity(),
  );
}
