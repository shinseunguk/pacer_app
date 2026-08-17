import '../entities/job_category.dart';

abstract interface class JobRepository {
  Future<List<JobCategory>> getCategories();
}
