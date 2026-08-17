// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legal_document_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LegalSectionModel _$LegalSectionModelFromJson(Map<String, dynamic> json) =>
    _LegalSectionModel(
      heading: json['heading'] as String,
      body: json['body'] as String,
    );

Map<String, dynamic> _$LegalSectionModelToJson(_LegalSectionModel instance) =>
    <String, dynamic>{'heading': instance.heading, 'body': instance.body};

_LegalDocumentModel _$LegalDocumentModelFromJson(Map<String, dynamic> json) =>
    _LegalDocumentModel(
      type: json['type'] as String,
      title: json['title'] as String,
      version: json['version'] as String,
      effectiveDate: json['effectiveDate'] as String,
      sections:
          (json['sections'] as List<dynamic>?)
              ?.map(
                (e) => LegalSectionModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <LegalSectionModel>[],
    );

Map<String, dynamic> _$LegalDocumentModelToJson(_LegalDocumentModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'version': instance.version,
      'effectiveDate': instance.effectiveDate,
      'sections': instance.sections,
    };
