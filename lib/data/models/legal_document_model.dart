import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/legal_document.dart';

part 'legal_document_model.freezed.dart';
part 'legal_document_model.g.dart';

@freezed
abstract class LegalSectionModel with _$LegalSectionModel {
  const LegalSectionModel._();

  const factory LegalSectionModel({
    required String heading,
    required String body,
  }) = _LegalSectionModel;

  factory LegalSectionModel.fromJson(Map<String, dynamic> json) =>
      _$LegalSectionModelFromJson(json);

  LegalSection toEntity() => LegalSection(heading: heading, body: body);
}

/// `GET /legal/{type}` 응답.
@freezed
abstract class LegalDocumentModel with _$LegalDocumentModel {
  const LegalDocumentModel._();

  const factory LegalDocumentModel({
    required String type,
    required String title,
    required String version,
    required String effectiveDate,
    @Default(<LegalSectionModel>[]) List<LegalSectionModel> sections,
  }) = _LegalDocumentModel;

  factory LegalDocumentModel.fromJson(Map<String, dynamic> json) =>
      _$LegalDocumentModelFromJson(json);

  LegalDocument toEntity() => LegalDocument(
    type: LegalDocumentType.fromValue(type),
    title: title,
    version: version,
    effectiveDate: effectiveDate,
    sections: sections.map((section) => section.toEntity()).toList(),
  );
}
