import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/job_category.dart';

part 'job_category_model.freezed.dart';
part 'job_category_model.g.dart';

@freezed
abstract class JobRoleModel with _$JobRoleModel {
  const JobRoleModel._();

  const factory JobRoleModel({required String id, required String name}) =
      _JobRoleModel;

  factory JobRoleModel.fromJson(Map<String, dynamic> json) =>
      _$JobRoleModelFromJson(json);

  JobRole toEntity() => JobRole(id: id, name: name);
}

/// `GET /jobs/categories` 응답 원소.
@freezed
abstract class JobCategoryModel with _$JobCategoryModel {
  const JobCategoryModel._();

  const factory JobCategoryModel({
    required String id,
    required String name,
    @Default(<JobRoleModel>[]) List<JobRoleModel> roles,
  }) = _JobCategoryModel;

  factory JobCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$JobCategoryModelFromJson(json);

  JobCategory toEntity() => JobCategory(
    id: id,
    name: name,
    roles: roles.map((role) => role.toEntity()).toList(),
  );
}
