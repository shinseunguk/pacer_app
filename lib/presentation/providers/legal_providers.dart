import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/legal_remote_data_source.dart';
import '../../data/repositories/legal_repository_impl.dart';
import '../../domain/entities/legal_document.dart';
import '../../domain/repositories/legal_repository.dart';
import 'app_providers.dart';

final legalRepositoryProvider = Provider<LegalRepository>(
  (ref) => LegalRepositoryImpl(LegalRemoteDataSource(ref.watch(dioProvider))),
);

/// 약관·처리방침 원문 (가입 전에도 열람 가능).
final legalDocumentProvider = FutureProvider.autoDispose
    .family<LegalDocument, LegalDocumentType>(
      (ref, type) => ref.watch(legalRepositoryProvider).getDocument(type),
    );
