// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppL10nEn extends AppL10n {
  AppL10nEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Pacer';

  @override
  String get appTagline => 'Don\'t run the interview alone';

  @override
  String get commonNext => 'Next';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonStart => 'Start';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonConfirm => 'OK';

  @override
  String get commonSkip => 'Skip';

  @override
  String get commonLoadFailed => 'Couldn\'t load this.';

  @override
  String get loginKakao => 'Start with Kakao';

  @override
  String get loginApple => 'Start with Apple';

  @override
  String get loginDevMock => 'Continue with a test account (dev)';

  @override
  String get loginTermsNotice =>
      'By signing in you agree to the Terms of Service and Privacy Policy.';

  @override
  String get loginFailed => 'Sign-in failed. Please try again.';

  @override
  String get onboardingNicknameTitle => 'What should we call you?';

  @override
  String get onboardingNicknameDescription =>
      'The interviewer will use this name. You can change it later.';

  @override
  String get onboardingNicknameHint => 'Nickname (2-12 characters)';

  @override
  String get onboardingNicknameEmpty => 'Please enter a nickname.';

  @override
  String get onboardingNicknameTooLong =>
      'Nicknames can be up to 20 characters.';

  @override
  String get consentTitle => 'Please accept the terms';

  @override
  String get consentAll => 'Accept all';

  @override
  String get consentTerms => '[Required] Terms of Service';

  @override
  String get consentPrivacy => '[Required] Personal data collection and use';

  @override
  String get consentLlm => '[Required] AI processing of interview content';

  @override
  String get consentLlmDescription =>
      'Job posts, career details and answers you enter are sent to an AI model to generate questions and feedback.';

  @override
  String get consentMarketing => '[Optional] Marketing updates';

  @override
  String get consentRequired =>
      'You need to accept every required item to start.';

  @override
  String homeGreeting(String nickname) {
    return 'Hello, $nickname';
  }

  @override
  String homeQuotaRemaining(int remaining) {
    return '$remaining questions left today';
  }

  @override
  String get homeStartInterview => 'Start a new interview';

  @override
  String get homeRecentTitle => 'Recent interviews';

  @override
  String get homeHistory => 'History';

  @override
  String get homeEmptyHistory => 'No interviews yet. Start your first one.';

  @override
  String get homeSignOut => 'Sign out';

  @override
  String get prepTitle => 'Interview setup';

  @override
  String get prepSourcePaste => 'Paste a job post';

  @override
  String get prepSourceTemplate => 'Start from a role';

  @override
  String get prepPostingLabel => 'Job posting';

  @override
  String get prepPostingHint => 'Paste the responsibilities and requirements.';

  @override
  String get prepPostingEmpty => 'Please enter the job posting.';

  @override
  String get prepSelectJob => 'Choose a role';

  @override
  String get prepSelectJobEmpty => 'Pick a role or type your own.';

  @override
  String prepSelectedJob(String role) {
    return 'Selected role: $role';
  }

  @override
  String get jobTitle => 'Choose a role';

  @override
  String get jobCustomLabel => 'Not listed? Type it in';

  @override
  String get jobCustomHint => 'e.g. Robotics software';

  @override
  String get jobCustomApply => 'Use this role';

  @override
  String get applicantTitle => 'About you';

  @override
  String get applicantDescription =>
      'Adding your experience makes the questions more tailored. (optional)';

  @override
  String get applicantHint => 'e.g. 3 years building payment backends...';

  @override
  String get setupTitle => 'Interview options';

  @override
  String get setupType => 'Interview type';

  @override
  String get setupTypeGeneral => 'Standard';

  @override
  String get setupTypePressure => 'Pressure';

  @override
  String get setupDifficulty => 'Difficulty';

  @override
  String get setupDifficultyLow => 'Easy';

  @override
  String get setupDifficultyMid => 'Medium';

  @override
  String get setupDifficultyHigh => 'Hard';

  @override
  String get setupQuestionCount => 'Base questions';

  @override
  String setupQuestionCountValue(int count) {
    return '$count questions';
  }

  @override
  String get setupShowScore => 'Show scores in the report';

  @override
  String get setupStart => 'Start interview';

  @override
  String get interviewTitle => 'Interview';

  @override
  String interviewProgress(int current, int total) {
    return 'Question $current/$total';
  }

  @override
  String get interviewInputHint => 'Type your answer';

  @override
  String get interviewSend => 'Send';

  @override
  String get interviewSkip => 'I don\'t know';

  @override
  String get interviewSkipped => 'Skipped (no answer)';

  @override
  String get interviewPause => 'Pause';

  @override
  String get interviewPausedNotice =>
      'This interview is paused. Tap resume to continue.';

  @override
  String get interviewResume => 'Resume';

  @override
  String get interviewFinish => 'Finish and see the report';

  @override
  String get interviewSendFailed =>
      'Couldn\'t send that. Your answer is kept — please try again.';

  @override
  String get reportTitle => 'Final report';

  @override
  String get reportPass => 'Pass';

  @override
  String get reportFail => 'Fail';

  @override
  String get reportScoreHidden => 'Scores are hidden for this interview.';

  @override
  String get reportCriteriaTitle => 'Scores by criterion';

  @override
  String get reportReasonTitle => 'Why';

  @override
  String get reportHome => 'Back to home';

  @override
  String get reportTranscript => 'View transcript';

  @override
  String get criterionLogic => 'Logic';

  @override
  String get criterionJobFit => 'Job fit';

  @override
  String get criterionStructure => 'Structure';

  @override
  String get criterionKeyword => 'Domain terms';

  @override
  String get historyTitle => 'History';

  @override
  String get historyEmpty => 'No records yet. Start your first interview.';

  @override
  String get historyInProgress => 'In progress';

  @override
  String get transcriptTitle => 'Transcript';

  @override
  String get transcriptModelAnswer => 'Model answer';

  @override
  String get legalTitle => 'Legal';

  @override
  String legalVersion(String version, String date) {
    return 'Version $version · effective $date';
  }

  @override
  String get legalView => 'View';

  @override
  String get loginSubcopy =>
      'Your interview history and progress stay safe in your account.';

  @override
  String get loginNoticeTerms =>
      'By continuing you agree to the Terms of Service and Privacy Policy.';

  @override
  String get loginNoticeAi => 'What you enter is sent for AI analysis.';

  @override
  String get legalTerms => 'Terms of Service';

  @override
  String get legalPrivacy => 'Privacy Policy';

  @override
  String get homeSubcopy => 'Ready to get a step ahead today?';

  @override
  String get homeStreak => 'Day streak';

  @override
  String homeStreakDays(int days) {
    return '$days days';
  }

  @override
  String get homeQuotaTitle => 'Base questions today';

  @override
  String get homeQuotaNote => 'Follow-ups don\'t count · resets at midnight';

  @override
  String get homeHeroBadge => 'Ready?';

  @override
  String get homeHeroTitle => 'Start a new interview';

  @override
  String get homeHeroSubtitle =>
      'Paste a job post and run a tailored interview';

  @override
  String get homeHeroAction => 'Enter job post';

  @override
  String get homeSectionRecent => 'Recent interviews';

  @override
  String get homeSeeAll => 'See all';

  @override
  String get tabHome => 'Home';

  @override
  String get tabHistory => 'History';

  @override
  String get tabProfile => 'My';

  @override
  String get onboardingNicknameRule =>
      '2-12 characters: Korean, letters, numbers or emoji';

  @override
  String get onboardingNicknameTaken => 'That nickname is already taken.';

  @override
  String get profileEditNickname => 'Edit nickname';

  @override
  String get commonSave => 'Save';

  @override
  String get profileNicknameChanged => 'Nickname updated.';
}
