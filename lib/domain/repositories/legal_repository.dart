import '../entities/legal_document.dart';

abstract interface class LegalRepository {
  Future<LegalDocument> getDocument(LegalDocumentType type);
}
