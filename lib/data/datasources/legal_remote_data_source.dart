import 'package:dio/dio.dart';

import '../../core/network/api_paths.dart';
import '../../domain/entities/legal_document.dart';
import '../models/legal_document_model.dart';

class LegalRemoteDataSource {
  const LegalRemoteDataSource(this._dio);

  final Dio _dio;

  Future<LegalDocumentModel> getDocument(LegalDocumentType type) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiPaths.legalDocument(type.value),
    );
    return LegalDocumentModel.fromJson(response.data ?? const {});
  }
}
