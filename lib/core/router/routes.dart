/// Route paths. Keep in sync with the screen map (화면정의서 §1).
abstract final class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const onboardingNickname = '/onboarding/nickname';
  static const onboardingConsent = '/onboarding/consent';
  static const home = '/';

  // 면접 준비 (S11 → S11a → S12 → S13)
  static const interviewPrep = '/interviews/new';
  static const interviewJobCategory = '/interviews/new/job';
  static const interviewApplicant = '/interviews/new/applicant';
  static const interviewOptions = '/interviews/new/options';

  // 진행(S20) · 리포트(S30)
  static const interviewSessionPattern = '/interviews/:id';
  static const interviewReportPattern = '/interviews/:id/report';

  static String interviewSession(String id) => '/interviews/$id';
  static String interviewReport(String id) => '/interviews/$id/report';

  // 약관·처리방침 — 로그인·온보딩 중에도 열람 가능
  static const legalPattern = '/legal/:type';

  static String legal(String type) => '/legal/$type';

  // 히스토리(S40) · 대화 전문(S41) · 마이
  static const history = '/history';
  static const profile = '/profile';
  static const profileNickname = '/profile/nickname';
  static const transcriptPattern = '/transcript/:id';

  static String transcript(String id) => '/transcript/$id';
}
