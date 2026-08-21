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
  String get setupLength => 'Interview length';

  @override
  String get setupPresetQuick => 'Quick practice';

  @override
  String get setupPresetStandard => 'Full run';

  @override
  String get setupPresetDeep => 'In depth';

  @override
  String setupPresetMinutes(int minutes) {
    return 'About $minutes min';
  }

  @override
  String setupPresetTurns(int turns) {
    return '~$turns questions';
  }

  @override
  String get setupShowScore => 'Show scores in the report';

  @override
  String get setupStart => 'Start interview';

  @override
  String get interviewTitle => 'Interview';

  @override
  String get interviewWarmUp => 'Warm-up';

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
  String get interviewCoachName => 'Pacer';

  @override
  String get interviewRetry => 'Try again';

  @override
  String get interviewPauseSheetTitle => 'Pause this interview?';

  @override
  String get interviewPauseSheetDesc =>
      'Everything so far is saved. You can pick it up from home anytime.';

  @override
  String get interviewContinue => 'Keep going';

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

  @override
  String get reportFeedbackQuestion => 'Was this report helpful?';

  @override
  String get reportFeedbackUp => 'Helpful';

  @override
  String get reportFeedbackDown => 'Not really';

  @override
  String get reportFeedbackThanks =>
      'Thanks — we\'ll use this to improve the evaluation.';

  @override
  String get reportFeedbackReasonHint => 'What fell short? (optional)';

  @override
  String get reportFeedbackSend => 'Send';

  @override
  String get reportFeedbackFailed =>
      'Couldn\'t send your feedback. Please try again.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsAccount => 'Account';

  @override
  String get settingsLegal => 'Legal';

  @override
  String get settingsWithdraw => 'Delete account';

  @override
  String get settingsWithdrawConfirmTitle => 'Delete your account?';

  @override
  String get settingsWithdrawConfirmBody =>
      'Your interviews and reports will be deleted permanently. Job posts and career details you entered are destroyed without delay.';

  @override
  String get settingsWithdrawConfirm => 'Delete';

  @override
  String get settingsWithdrawFailed =>
      'Couldn\'t delete your account. Please try again.';

  @override
  String get settingsLogoutConfirmTitle => 'Sign out?';

  @override
  String get settingsLogoutConfirmBody =>
      'Your records stay saved. Sign back in any time to pick up where you left off.';

  @override
  String get historyNoRole => 'No role selected';

  @override
  String get interviewExit => 'Save and exit';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsAppearanceSystem => 'System';

  @override
  String get settingsAppearanceLight => 'Light';

  @override
  String get settingsAppearanceDark => 'Dark';

  @override
  String get homeFreeTitle => 'Free trial';

  @override
  String homeFreeRemaining(int remaining) {
    return '$remaining left';
  }

  @override
  String get homeFreeNote => '5-question interview · no daily reset';

  @override
  String get homeProTitle => 'Pro · unlimited';

  @override
  String homeProRenewal(String date) {
    return 'Renews $date';
  }

  @override
  String get homeProNoRenewal => 'Reverts to free after this period';

  @override
  String get homeFreeExhausted => 'You\'ve used your free trial';

  @override
  String get lastFreeTitle => 'This is your last free interview';

  @override
  String get lastFreeBody => 'After this one, you can continue with Pro.';

  @override
  String get lastFreeStart => 'Start';

  @override
  String get presetLockedTitle => 'Pro-only length';

  @override
  String get presetLockedBody =>
      'Free trials run as Quick practice. Go Pro for longer sessions.';

  @override
  String get reportUpsellTitle => 'You\'ve used your free trial';

  @override
  String get reportUpsellBody => 'Continue unlimited with Pro';

  @override
  String get reportUpsellPrice => '₩9,900 / month';

  @override
  String get paywallTitle => 'Pacer Pro';

  @override
  String get paywallHeadline => 'Practice without counting';

  @override
  String get paywallSubhead => 'If two free interviews weren\'t enough';

  @override
  String get paywallBenefitUnlimited => 'Unlimited interviews';

  @override
  String get paywallBenefitUnlimitedNote =>
      'Practice with a new posting any day';

  @override
  String get paywallBenefitLength => '5 · 10 · 15 questions';

  @override
  String get paywallBenefitLengthNote => 'As long as the real thing';

  @override
  String get paywallBenefitReport => 'Full report and model answers';

  @override
  String get paywallBenefitReportNote => 'What to fix, question by question';

  @override
  String get paywallPrice => '₩9,900 / month';

  @override
  String get paywallCta => 'Start Pro';

  @override
  String get paywallRestore => 'Restore purchase';

  @override
  String get paywallRestoreEmpty => 'No purchase to restore.';

  @override
  String get paywallRestoreDone => 'Your subscription was restored.';

  @override
  String get paywallDone => 'Pro is active. Practice without limits.';

  @override
  String get paywallTermsTitle => 'Subscription details';

  @override
  String get paywallTermsRenewal =>
      '₩9,900 per month, auto-renewing. It renews automatically unless cancelled at least 24 hours before the period ends.';

  @override
  String get paywallTermsCancel =>
      'Cancel any time in Settings > Account > Subscriptions. You keep access until the current period ends.';

  @override
  String get paywallTermsLinks =>
      'By subscribing you agree to the Terms and Privacy Policy.';

  @override
  String get paywallTerms => 'Terms of Service';

  @override
  String get paywallPrivacy => 'Privacy Policy';

  @override
  String get reportLoadingTitle => 'Scoring your interview';

  @override
  String get reportLoadingStep1 => 'Re-reading the conversation';

  @override
  String get reportLoadingStep2 => 'Scoring each criterion';

  @override
  String get reportLoadingStep3 => 'Writing model answers';

  @override
  String get reportLoadingStep4 => 'Almost there';

  @override
  String get reportLoadingNote =>
      'A careful read takes 1–2 minutes. Scoring continues if you leave.';

  @override
  String profileEntitlementFree(int remaining) {
    return 'Free trial · $remaining left';
  }

  @override
  String get introSkip => 'Skip';

  @override
  String get introNext => 'Next';

  @override
  String get introStart => 'Get started';

  @override
  String get introBadge1 => 'AI interview coach';

  @override
  String get introTitle1 => 'Don\'t run\nthis alone';

  @override
  String get introBody1 =>
      'Paste a job posting and Pacer runs a real interview tailored to that role.';

  @override
  String get introBadge2 => 'Tailored questions · follow-ups';

  @override
  String get introTitle2 => 'Straight from\nthe posting';

  @override
  String get introBody2 =>
      'Questions are built from the posting, and follow-ups dig into your answers.';

  @override
  String get introBadge3 => 'Scores · growth';

  @override
  String get introTitle3 => 'A pace that\ngets faster';

  @override
  String get introBody3 =>
      'Every answer is scored by criterion, and your progress shows up as a graph.';

  @override
  String get introArtQuestion => 'Which project stands out most?';

  @override
  String get introArtAnswer => 'I halved response time on the detail page…';

  @override
  String get introArtFollowUp => 'How did you find the bottleneck?';

  @override
  String get introArtFollowUpBadge => 'Follow-up';

  @override
  String get profilePlanFree => 'Free plan';

  @override
  String get profilePlanPro => 'Pacer Pro';

  @override
  String get profileEdit => 'Edit';

  @override
  String get profileUpsellTitle => 'Practice as much\nas you want';

  @override
  String get profileUpsellBenefit1 => 'Unlimited interviews';

  @override
  String get profileUpsellBenefit2 => '5 · 10 · 15 questions';

  @override
  String get profileUpsellBenefit3 => 'Full report and model answers';

  @override
  String get profileUpsellCta => 'Start Pro · ₩9,900/month';

  @override
  String get historyGrowthTitle => 'Your progress';

  @override
  String get historyGrowthSubtitle => 'See the pace you\'re building';

  @override
  String get historyTabTrend => 'Trend';

  @override
  String get historyTabSkill => 'Skills';

  @override
  String get historyStreak => 'Streak';

  @override
  String historyStreakDays(int days) {
    return '$days days';
  }

  @override
  String get historyTotal => 'Interviews';

  @override
  String historyTotalCount(int count) {
    return '$count';
  }

  @override
  String get historyTrendTitle => 'Overall score trend';

  @override
  String historyTrendDelta(String delta) {
    return 'Latest $delta';
  }

  @override
  String get historyAverage => 'Average';

  @override
  String get historyBestGrade => 'Best grade';

  @override
  String get historyPassCount => 'Likely pass';

  @override
  String historyPassCountValue(int count) {
    return '$count';
  }

  @override
  String get historySkillTitle => 'Latest interview · by criterion';

  @override
  String historyWeakest(String label, int score) {
    return 'Your weakest area is $label ($score).';
  }

  @override
  String get historyGrowthEmptyTitle => 'Nothing here yet';

  @override
  String get historyGrowthEmptyBody =>
      'Finish two interviews to see\nyour trend and weak spots.';

  @override
  String get historyGrowthEmptyCta => 'Start your first interview';

  @override
  String get historyListLabel => 'Interview history';
}
