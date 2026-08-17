import 'package:dio/dio.dart';

import '../../core/error/error_mapper.dart';
import '../../domain/entities/legal_document.dart';
import '../../domain/repositories/legal_repository.dart';
import '../datasources/legal_remote_data_source.dart';

class LegalRepositoryImpl implements LegalRepository {
  const LegalRepositoryImpl(this._remote);

  final LegalRemoteDataSource _remote;

  @override
  Future<LegalDocument> getDocument(LegalDocumentType type) async {
    try {
      final model = await _remote.getDocument(type);
      return model.toEntity();
    } on DioException catch (error) {
      throw mapDioException(error);
    }
  }
}
