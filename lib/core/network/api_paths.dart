/// Server endpoints (contract: pacer_server/docs/Pacer_API명세_v1.md).
/// Base URL already contains the `/v1` prefix.
abstract final class ApiPaths {
  static String login(String provider) => '/auth/login/$provider';
  static const refresh = '/auth/refresh';
  static const logout = '/auth/logout';

  static const onboarding = '/users/onboarding';
  static const me = '/users/me';
  static const nicknameAvailability = '/users/nickname/availability';

  static const jobCategories = '/jobs/categories';

  static const legal = '/legal';
  static String legalDocument(String type) => '/legal/$type';

  static const interviews = '/interviews';
  static String interview(String id) => '/interviews/$id';
  static String answer(String id) => '/interviews/$id/answer';
  static String skip(String id) => '/interviews/$id/skip';
  static String pause(String id) => '/interviews/$id/pause';
  static String resume(String id) => '/interviews/$id/resume';
  static String complete(String id) => '/interviews/$id/complete';
  static String interviewFeedback(String id) => '/interviews/$id/feedback';
}
