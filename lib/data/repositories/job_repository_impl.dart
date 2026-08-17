import 'package:dio/dio.dart';

import '../../core/error/error_mapper.dart';
import '../../domain/entities/job_category.dart';
import '../../domain/repositories/job_repository.dart';
import '../datasources/job_remote_data_source.dart';

class JobRepositoryImpl implements JobRepository {
  const JobRepositoryImpl(this._remote);

  final JobRemoteDataSource _remote;

  @override
  Future<List<JobCategory>> getCategories() async {
    try {
      final models = await _remote.getCategories();
      return models.map((model) => model.toEntity()).toList();
    } on DioException catch (error) {
      throw mapDioException(error);
    }
  }
}
