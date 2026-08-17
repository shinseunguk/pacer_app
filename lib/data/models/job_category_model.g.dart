// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobRoleModel _$JobRoleModelFromJson(Map<String, dynamic> json) =>
    _JobRoleModel(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$JobRoleModelToJson(_JobRoleModel instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_JobCategoryModel _$JobCategoryModelFromJson(Map<String, dynamic> json) =>
    _JobCategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      roles:
          (json['roles'] as List<dynamic>?)
              ?.map((e) => JobRoleModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <JobRoleModel>[],
    );

Map<String, dynamic> _$JobCategoryModelToJson(_JobCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'roles': instance.roles,
    };
