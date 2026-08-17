/// 약관·처리방침 종류 (`GET /legal/{type}`).
enum LegalDocumentType {
  terms('terms'),
  privacy('privacy');

  const LegalDocumentType(this.value);

  final String value;

  static LegalDocumentType fromValue(String value) {
    return LegalDocumentType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => LegalDocumentType.terms,
    );
  }
}

class LegalSection {
  const LegalSection({required this.heading, required this.body});

  final String heading;
  final String body;
}

class LegalDocument {
  const LegalDocument({
    required this.type,
    required this.title,
    required this.version,
    required this.effectiveDate,
    required this.sections,
  });

  final LegalDocumentType type;
  final String title;

  /// 동의 이력과 대조하기 위한 문서 버전.
  final String version;
  final String effectiveDate;
  final List<LegalSection> sections;
}
