/// 세부 직무 (S11a).
class JobRole {
  const JobRole({required this.id, required this.name});

  final String id;
  final String name;
}

/// 직무 대분류 + 세부 목록.
class JobCategory {
  const JobCategory({
    required this.id,
    required this.name,
    required this.roles,
  });

  final String id;
  final String name;
  final List<JobRole> roles;
}
