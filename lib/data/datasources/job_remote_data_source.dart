import 'package:dio/dio.dart';

import '../../core/network/api_paths.dart';
import '../models/job_category_model.dart';

class JobRemoteDataSource {
  const JobRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<JobCategoryModel>> getCategories() async {
    final response = await _dio.get<List<dynamic>>(ApiPaths.jobCategories);

    return (response.data ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(JobCategoryModel.fromJson)
        .toList();
  }
}
