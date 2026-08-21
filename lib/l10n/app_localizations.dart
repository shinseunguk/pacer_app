import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppL10n
/// returned by `AppL10n.of(context)`.
///
/// Applications need to include `AppL10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppL10n.localizationsDelegates,
///   supportedLocales: AppL10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppL10n.supportedLocales
/// property.
abstract class AppL10n {
  AppL10n(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppL10n of(BuildContext context) {
    return Localizations.of<AppL10n>(context, AppL10n)!;
  }

  static const LocalizationsDelegate<AppL10n> delegate = _AppL10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ko'),
  ];

  /// No description provided for @appName.
  ///
  /// In ko, this message translates to:
  /// **'페이서'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In ko, this message translates to:
  /// **'면접, 혼자 뛰지 마세요'**
  String get appTagline;

  /// No description provided for @commonNext.
  ///
  /// In ko, this message translates to:
  /// **'다음'**
  String get commonNext;

  /// No description provided for @commonRetry.
  ///
  /// In ko, this message translates to:
  /// **'다시 시도'**
  String get commonRetry;

  /// No description provided for @commonStart.
  ///
  /// In ko, this message translates to:
  /// **'시작하기'**
  String get commonStart;

  /// No description provided for @commonCancel.
  ///
  /// In ko, this message translates to:
  /// **'취소'**
  String get commonCancel;

  /// No description provided for @commonConfirm.
  ///
  /// In ko, this message translates to:
  /// **'확인'**
  String get commonConfirm;

  /// No description provided for @commonSkip.
  ///
  /// In ko, this message translates to:
  /// **'건너뛰기'**
  String get commonSkip;

  /// No description provided for @commonLoadFailed.
  ///
  /// In ko, this message translates to:
  /// **'불러오지 못했어요.'**
  String get commonLoadFailed;

  /// No description provided for @loginKakao.
  ///
  /// In ko, this message translates to:
  /// **'카카오로 시작하기'**
  String get loginKakao;

  /// No description provided for @loginApple.
  ///
  /// In ko, this message translates to:
  /// **'Apple로 시작하기'**
  String get loginApple;

  /// No description provided for @loginDevMock.
  ///
  /// In ko, this message translates to:
  /// **'테스트 계정으로 계속하기 (dev)'**
  String get loginDevMock;

  /// No description provided for @loginTermsNotice.
  ///
  /// In ko, this message translates to:
  /// **'로그인하면 이용약관과 개인정보 처리방침에 동의하게 됩니다.'**
  String get loginTermsNotice;

  /// No description provided for @loginFailed.
  ///
  /// In ko, this message translates to:
  /// **'로그인하지 못했어요. 다시 시도해주세요.'**
  String get loginFailed;

  /// No description provided for @onboardingNicknameTitle.
  ///
  /// In ko, this message translates to:
  /// **'어떻게 불러드릴까요?'**
  String get onboardingNicknameTitle;

  /// No description provided for @onboardingNicknameDescription.
  ///
  /// In ko, this message translates to:
  /// **'면접관이 부를 이름이에요. 나중에 바꿀 수 있어요.'**
  String get onboardingNicknameDescription;

  /// No description provided for @onboardingNicknameHint.
  ///
  /// In ko, this message translates to:
  /// **'닉네임 (2~12자)'**
  String get onboardingNicknameHint;

  /// No description provided for @onboardingNicknameEmpty.
  ///
  /// In ko, this message translates to:
  /// **'닉네임을 입력해주세요.'**
  String get onboardingNicknameEmpty;

  /// No description provided for @onboardingNicknameTooLong.
  ///
  /// In ko, this message translates to:
  /// **'닉네임은 20자까지 입력할 수 있어요.'**
  String get onboardingNicknameTooLong;

  /// No description provided for @consentTitle.
  ///
  /// In ko, this message translates to:
  /// **'약관에 동의해주세요'**
  String get consentTitle;

  /// No description provided for @consentAll.
  ///
  /// In ko, this message translates to:
  /// **'전체 동의'**
  String get consentAll;

  /// No description provided for @consentTerms.
  ///
  /// In ko, this message translates to:
  /// **'[필수] 서비스 이용약관'**
  String get consentTerms;

  /// No description provided for @consentPrivacy.
  ///
  /// In ko, this message translates to:
  /// **'[필수] 개인정보 수집·이용 동의'**
  String get consentPrivacy;

  /// No description provided for @consentLlm.
  ///
  /// In ko, this message translates to:
  /// **'[필수] 면접 내용의 AI 처리 위탁 동의'**
  String get consentLlm;

  /// No description provided for @consentLlmDescription.
  ///
  /// In ko, this message translates to:
  /// **'입력한 공고·경력·답변은 면접 질문과 평가 생성을 위해 AI 모델로 전송돼요.'**
  String get consentLlmDescription;

  /// No description provided for @consentMarketing.
  ///
  /// In ko, this message translates to:
  /// **'[선택] 마케팅 정보 수신'**
  String get consentMarketing;

  /// No description provided for @consentRequired.
  ///
  /// In ko, this message translates to:
  /// **'필수 항목에 모두 동의해야 시작할 수 있어요.'**
  String get consentRequired;

  /// No description provided for @homeGreeting.
  ///
  /// In ko, this message translates to:
  /// **'안녕하세요, {nickname}님'**
  String homeGreeting(String nickname);

  /// No description provided for @homeQuotaRemaining.
  ///
  /// In ko, this message translates to:
  /// **'오늘 남은 질문 {remaining}개'**
  String homeQuotaRemaining(int remaining);

  /// No description provided for @homeStartInterview.
  ///
  /// In ko, this message translates to:
  /// **'새 면접 시작'**
  String get homeStartInterview;

  /// No description provided for @homeRecentTitle.
  ///
  /// In ko, this message translates to:
  /// **'최근 면접'**
  String get homeRecentTitle;

  /// No description provided for @homeHistory.
  ///
  /// In ko, this message translates to:
  /// **'히스토리'**
  String get homeHistory;

  /// No description provided for @homeEmptyHistory.
  ///
  /// In ko, this message translates to:
  /// **'아직 진행한 면접이 없어요. 첫 면접을 시작해보세요.'**
  String get homeEmptyHistory;

  /// No description provided for @homeSignOut.
  ///
  /// In ko, this message translates to:
  /// **'로그아웃'**
  String get homeSignOut;

  /// No description provided for @prepTitle.
  ///
  /// In ko, this message translates to:
  /// **'면접 준비'**
  String get prepTitle;

  /// No description provided for @prepSourcePaste.
  ///
  /// In ko, this message translates to:
  /// **'공고 붙여넣기'**
  String get prepSourcePaste;

  /// No description provided for @prepSourceTemplate.
  ///
  /// In ko, this message translates to:
  /// **'직무로 시작'**
  String get prepSourceTemplate;

  /// No description provided for @prepPostingLabel.
  ///
  /// In ko, this message translates to:
  /// **'채용 공고'**
  String get prepPostingLabel;

  /// No description provided for @prepPostingHint.
  ///
  /// In ko, this message translates to:
  /// **'주요 업무·자격요건을 붙여넣어 주세요.'**
  String get prepPostingHint;

  /// No description provided for @prepPostingEmpty.
  ///
  /// In ko, this message translates to:
  /// **'공고 내용을 입력해주세요.'**
  String get prepPostingEmpty;

  /// No description provided for @prepSelectJob.
  ///
  /// In ko, this message translates to:
  /// **'직무 선택'**
  String get prepSelectJob;

  /// No description provided for @prepSelectJobEmpty.
  ///
  /// In ko, this message translates to:
  /// **'직무를 선택하거나 직접 입력해주세요.'**
  String get prepSelectJobEmpty;

  /// No description provided for @prepSelectedJob.
  ///
  /// In ko, this message translates to:
  /// **'선택한 직무: {role}'**
  String prepSelectedJob(String role);

  /// No description provided for @jobTitle.
  ///
  /// In ko, this message translates to:
  /// **'직무 선택'**
  String get jobTitle;

  /// No description provided for @jobCustomLabel.
  ///
  /// In ko, this message translates to:
  /// **'목록에 없다면 직접 입력'**
  String get jobCustomLabel;

  /// No description provided for @jobCustomHint.
  ///
  /// In ko, this message translates to:
  /// **'예: 로봇 소프트웨어'**
  String get jobCustomHint;

  /// No description provided for @jobCustomApply.
  ///
  /// In ko, this message translates to:
  /// **'직접 입력한 직무 사용'**
  String get jobCustomApply;

  /// No description provided for @applicantTitle.
  ///
  /// In ko, this message translates to:
  /// **'지원자 정보'**
  String get applicantTitle;

  /// No description provided for @applicantDescription.
  ///
  /// In ko, this message translates to:
  /// **'경력·자기소개를 적으면 더 맞춤형 질문이 나와요. (선택)'**
  String get applicantDescription;

  /// No description provided for @applicantHint.
  ///
  /// In ko, this message translates to:
  /// **'예: 경력 3년, 결제 시스템 백엔드 개발...'**
  String get applicantHint;

  /// No description provided for @setupTitle.
  ///
  /// In ko, this message translates to:
  /// **'면접 설정'**
  String get setupTitle;

  /// No description provided for @setupType.
  ///
  /// In ko, this message translates to:
  /// **'면접 유형'**
  String get setupType;

  /// No description provided for @setupTypeGeneral.
  ///
  /// In ko, this message translates to:
  /// **'일반'**
  String get setupTypeGeneral;

  /// No description provided for @setupTypePressure.
  ///
  /// In ko, this message translates to:
  /// **'압박'**
  String get setupTypePressure;

  /// No description provided for @setupDifficulty.
  ///
  /// In ko, this message translates to:
  /// **'난이도'**
  String get setupDifficulty;

  /// No description provided for @setupDifficultyLow.
  ///
  /// In ko, this message translates to:
  /// **'쉬움'**
  String get setupDifficultyLow;

  /// No description provided for @setupDifficultyMid.
  ///
  /// In ko, this message translates to:
  /// **'보통'**
  String get setupDifficultyMid;

  /// No description provided for @setupDifficultyHigh.
  ///
  /// In ko, this message translates to:
  /// **'어려움'**
  String get setupDifficultyHigh;

  /// No description provided for @setupLength.
  ///
  /// In ko, this message translates to:
  /// **'면접 길이'**
  String get setupLength;

  /// No description provided for @setupPresetQuick.
  ///
  /// In ko, this message translates to:
  /// **'빠른 연습'**
  String get setupPresetQuick;

  /// No description provided for @setupPresetStandard.
  ///
  /// In ko, this message translates to:
  /// **'실전'**
  String get setupPresetStandard;

  /// No description provided for @setupPresetDeep.
  ///
  /// In ko, this message translates to:
  /// **'심층'**
  String get setupPresetDeep;

  /// No description provided for @setupPresetMinutes.
  ///
  /// In ko, this message translates to:
  /// **'약 {minutes}분'**
  String setupPresetMinutes(int minutes);

  /// No description provided for @setupPresetTurns.
  ///
  /// In ko, this message translates to:
  /// **'질문 {turns}개 내외'**
  String setupPresetTurns(int turns);

  /// No description provided for @setupShowScore.
  ///
  /// In ko, this message translates to:
  /// **'리포트에 점수 표시'**
  String get setupShowScore;

  /// No description provided for @setupStart.
  ///
  /// In ko, this message translates to:
  /// **'면접 시작'**
  String get setupStart;

  /// No description provided for @interviewTitle.
  ///
  /// In ko, this message translates to:
  /// **'면접 진행'**
  String get interviewTitle;

  /// No description provided for @interviewWarmUp.
  ///
  /// In ko, this message translates to:
  /// **'워밍업 · 가볍게 시작해요'**
  String get interviewWarmUp;

  /// No description provided for @interviewProgress.
  ///
  /// In ko, this message translates to:
  /// **'질문 {current}/{total}'**
  String interviewProgress(int current, int total);

  /// No description provided for @interviewInputHint.
  ///
  /// In ko, this message translates to:
  /// **'답변을 입력하세요'**
  String get interviewInputHint;

  /// No description provided for @interviewSend.
  ///
  /// In ko, this message translates to:
  /// **'전송'**
  String get interviewSend;

  /// No description provided for @interviewSkip.
  ///
  /// In ko, this message translates to:
  /// **'모르겠습니다'**
  String get interviewSkip;

  /// No description provided for @interviewSkipped.
  ///
  /// In ko, this message translates to:
  /// **'모르겠습니다 (미응답)'**
  String get interviewSkipped;

  /// No description provided for @interviewPause.
  ///
  /// In ko, this message translates to:
  /// **'일시정지'**
  String get interviewPause;

  /// No description provided for @interviewPausedNotice.
  ///
  /// In ko, this message translates to:
  /// **'일시정지된 면접이에요. 이어하기를 누르면 계속됩니다.'**
  String get interviewPausedNotice;

  /// No description provided for @interviewResume.
  ///
  /// In ko, this message translates to:
  /// **'이어하기'**
  String get interviewResume;

  /// No description provided for @interviewFinish.
  ///
  /// In ko, this message translates to:
  /// **'면접 종료하고 리포트 보기'**
  String get interviewFinish;

  /// No description provided for @interviewSendFailed.
  ///
  /// In ko, this message translates to:
  /// **'전송하지 못했어요. 답변은 그대로 두었으니 다시 시도해주세요.'**
  String get interviewSendFailed;

  /// No description provided for @interviewCoachName.
  ///
  /// In ko, this message translates to:
  /// **'페이서'**
  String get interviewCoachName;

  /// No description provided for @interviewRetry.
  ///
  /// In ko, this message translates to:
  /// **'다시 시도'**
  String get interviewRetry;

  /// No description provided for @interviewPauseSheetTitle.
  ///
  /// In ko, this message translates to:
  /// **'면접을 잠시 멈출까요?'**
  String get interviewPauseSheetTitle;

  /// No description provided for @interviewPauseSheetDesc.
  ///
  /// In ko, this message translates to:
  /// **'지금까지 대화는 저장돼요. 홈에서 언제든 이어할 수 있어요.'**
  String get interviewPauseSheetDesc;

  /// No description provided for @interviewContinue.
  ///
  /// In ko, this message translates to:
  /// **'이어서 진행'**
  String get interviewContinue;

  /// No description provided for @reportTitle.
  ///
  /// In ko, this message translates to:
  /// **'최종 리포트'**
  String get reportTitle;

  /// No description provided for @reportPass.
  ///
  /// In ko, this message translates to:
  /// **'합격'**
  String get reportPass;

  /// No description provided for @reportFail.
  ///
  /// In ko, this message translates to:
  /// **'불합격'**
  String get reportFail;

  /// No description provided for @reportScoreHidden.
  ///
  /// In ko, this message translates to:
  /// **'점수 표시를 꺼둔 면접이에요.'**
  String get reportScoreHidden;

  /// No description provided for @reportCriteriaTitle.
  ///
  /// In ko, this message translates to:
  /// **'항목별 점수'**
  String get reportCriteriaTitle;

  /// No description provided for @reportReasonTitle.
  ///
  /// In ko, this message translates to:
  /// **'판정 근거'**
  String get reportReasonTitle;

  /// No description provided for @reportHome.
  ///
  /// In ko, this message translates to:
  /// **'홈으로'**
  String get reportHome;

  /// No description provided for @reportTranscript.
  ///
  /// In ko, this message translates to:
  /// **'대화 전문 보기'**
  String get reportTranscript;

  /// No description provided for @criterionLogic.
  ///
  /// In ko, this message translates to:
  /// **'논리'**
  String get criterionLogic;

  /// No description provided for @criterionJobFit.
  ///
  /// In ko, this message translates to:
  /// **'직무 적합'**
  String get criterionJobFit;

  /// No description provided for @criterionStructure.
  ///
  /// In ko, this message translates to:
  /// **'답변 구조'**
  String get criterionStructure;

  /// No description provided for @criterionKeyword.
  ///
  /// In ko, this message translates to:
  /// **'전문성'**
  String get criterionKeyword;

  /// No description provided for @historyTitle.
  ///
  /// In ko, this message translates to:
  /// **'히스토리'**
  String get historyTitle;

  /// No description provided for @historyEmpty.
  ///
  /// In ko, this message translates to:
  /// **'아직 기록이 없어요. 첫 면접을 시작해보세요.'**
  String get historyEmpty;

  /// No description provided for @historyInProgress.
  ///
  /// In ko, this message translates to:
  /// **'진행 중'**
  String get historyInProgress;

  /// No description provided for @transcriptTitle.
  ///
  /// In ko, this message translates to:
  /// **'대화 전문'**
  String get transcriptTitle;

  /// No description provided for @transcriptModelAnswer.
  ///
  /// In ko, this message translates to:
  /// **'모범답안'**
  String get transcriptModelAnswer;

  /// No description provided for @legalTitle.
  ///
  /// In ko, this message translates to:
  /// **'약관'**
  String get legalTitle;

  /// No description provided for @legalVersion.
  ///
  /// In ko, this message translates to:
  /// **'버전 {version} · 시행일 {date}'**
  String legalVersion(String version, String date);

  /// No description provided for @legalView.
  ///
  /// In ko, this message translates to:
  /// **'보기'**
  String get legalView;

  /// No description provided for @loginSubcopy.
  ///
  /// In ko, this message translates to:
  /// **'면접 이력과 성장 추이는 계정에 안전하게 저장돼요.'**
  String get loginSubcopy;

  /// No description provided for @loginNoticeTerms.
  ///
  /// In ko, this message translates to:
  /// **'계속하면 이용약관 및 개인정보 처리방침에 동의하는 것으로 간주됩니다.'**
  String get loginNoticeTerms;

  /// No description provided for @loginNoticeAi.
  ///
  /// In ko, this message translates to:
  /// **'입력한 내용은 AI 분석을 위해 전송돼요.'**
  String get loginNoticeAi;

  /// No description provided for @legalTerms.
  ///
  /// In ko, this message translates to:
  /// **'이용약관'**
  String get legalTerms;

  /// No description provided for @legalPrivacy.
  ///
  /// In ko, this message translates to:
  /// **'개인정보 처리방침'**
  String get legalPrivacy;

  /// No description provided for @homeSubcopy.
  ///
  /// In ko, this message translates to:
  /// **'오늘도 한 발 앞서 준비해볼까요?'**
  String get homeSubcopy;

  /// No description provided for @homeStreak.
  ///
  /// In ko, this message translates to:
  /// **'연속 연습'**
  String get homeStreak;

  /// No description provided for @homeStreakDays.
  ///
  /// In ko, this message translates to:
  /// **'{days}일'**
  String homeStreakDays(int days);

  /// No description provided for @homeQuotaTitle.
  ///
  /// In ko, this message translates to:
  /// **'오늘 기본 질문'**
  String get homeQuotaTitle;

  /// No description provided for @homeQuotaNote.
  ///
  /// In ko, this message translates to:
  /// **'꼬리질문 미차감 · 자정 초기화'**
  String get homeQuotaNote;

  /// No description provided for @homeHeroBadge.
  ///
  /// In ko, this message translates to:
  /// **'준비됐나요?'**
  String get homeHeroBadge;

  /// No description provided for @homeHeroTitle.
  ///
  /// In ko, this message translates to:
  /// **'새 면접 시작하기'**
  String get homeHeroTitle;

  /// No description provided for @homeHeroSubtitle.
  ///
  /// In ko, this message translates to:
  /// **'공고를 넣고 맞춤 면접을 뛰어보세요'**
  String get homeHeroSubtitle;

  /// No description provided for @homeHeroAction.
  ///
  /// In ko, this message translates to:
  /// **'공고 입력'**
  String get homeHeroAction;

  /// No description provided for @homeSectionRecent.
  ///
  /// In ko, this message translates to:
  /// **'최근 면접'**
  String get homeSectionRecent;

  /// No description provided for @homeSeeAll.
  ///
  /// In ko, this message translates to:
  /// **'전체 보기'**
  String get homeSeeAll;

  /// No description provided for @tabHome.
  ///
  /// In ko, this message translates to:
  /// **'홈'**
  String get tabHome;

  /// No description provided for @tabHistory.
  ///
  /// In ko, this message translates to:
  /// **'기록'**
  String get tabHistory;

  /// No description provided for @tabProfile.
  ///
  /// In ko, this message translates to:
  /// **'마이'**
  String get tabProfile;

  /// No description provided for @onboardingNicknameRule.
  ///
  /// In ko, this message translates to:
  /// **'한글·영문·숫자·이모지로 2~12자'**
  String get onboardingNicknameRule;

  /// No description provided for @onboardingNicknameTaken.
  ///
  /// In ko, this message translates to:
  /// **'이미 사용 중인 닉네임이에요.'**
  String get onboardingNicknameTaken;

  /// No description provided for @profileEditNickname.
  ///
  /// In ko, this message translates to:
  /// **'닉네임 수정'**
  String get profileEditNickname;

  /// No description provided for @commonSave.
  ///
  /// In ko, this message translates to:
  /// **'저장'**
  String get commonSave;

  /// No description provided for @profileNicknameChanged.
  ///
  /// In ko, this message translates to:
  /// **'닉네임을 바꿨어요.'**
  String get profileNicknameChanged;

  /// No description provided for @reportFeedbackQuestion.
  ///
  /// In ko, this message translates to:
  /// **'이 리포트가 도움이 되었나요?'**
  String get reportFeedbackQuestion;

  /// No description provided for @reportFeedbackUp.
  ///
  /// In ko, this message translates to:
  /// **'도움돼요'**
  String get reportFeedbackUp;

  /// No description provided for @reportFeedbackDown.
  ///
  /// In ko, this message translates to:
  /// **'아쉬워요'**
  String get reportFeedbackDown;

  /// No description provided for @reportFeedbackThanks.
  ///
  /// In ko, this message translates to:
  /// **'의견 고마워요. 평가 품질을 높이는 데 쓸게요.'**
  String get reportFeedbackThanks;

  /// No description provided for @reportFeedbackReasonHint.
  ///
  /// In ko, this message translates to:
  /// **'어떤 점이 아쉬웠나요? (선택)'**
  String get reportFeedbackReasonHint;

  /// No description provided for @reportFeedbackSend.
  ///
  /// In ko, this message translates to:
  /// **'보내기'**
  String get reportFeedbackSend;

  /// No description provided for @reportFeedbackFailed.
  ///
  /// In ko, this message translates to:
  /// **'의견을 보내지 못했어요. 잠시 후 다시 시도해주세요.'**
  String get reportFeedbackFailed;

  /// No description provided for @settingsTitle.
  ///
  /// In ko, this message translates to:
  /// **'설정'**
  String get settingsTitle;

  /// No description provided for @settingsAccount.
  ///
  /// In ko, this message translates to:
  /// **'계정'**
  String get settingsAccount;

  /// No description provided for @settingsLegal.
  ///
  /// In ko, this message translates to:
  /// **'약관·정책'**
  String get settingsLegal;

  /// No description provided for @settingsWithdraw.
  ///
  /// In ko, this message translates to:
  /// **'회원 탈퇴'**
  String get settingsWithdraw;

  /// No description provided for @settingsWithdrawConfirmTitle.
  ///
  /// In ko, this message translates to:
  /// **'정말 탈퇴하시겠어요?'**
  String get settingsWithdrawConfirmTitle;

  /// No description provided for @settingsWithdrawConfirmBody.
  ///
  /// In ko, this message translates to:
  /// **'탈퇴하면 면접 기록과 평가가 모두 삭제되고 되돌릴 수 없어요. 입력하신 공고·경력 정보도 지체 없이 파기돼요.'**
  String get settingsWithdrawConfirmBody;

  /// No description provided for @settingsWithdrawConfirm.
  ///
  /// In ko, this message translates to:
  /// **'탈퇴하기'**
  String get settingsWithdrawConfirm;

  /// No description provided for @settingsWithdrawFailed.
  ///
  /// In ko, this message translates to:
  /// **'탈퇴하지 못했어요. 잠시 후 다시 시도해주세요.'**
  String get settingsWithdrawFailed;

  /// No description provided for @settingsLogoutConfirmTitle.
  ///
  /// In ko, this message translates to:
  /// **'로그아웃할까요?'**
  String get settingsLogoutConfirmTitle;

  /// No description provided for @settingsLogoutConfirmBody.
  ///
  /// In ko, this message translates to:
  /// **'기록은 그대로 남아 있어요. 다시 로그인하면 이어서 볼 수 있어요.'**
  String get settingsLogoutConfirmBody;

  /// No description provided for @historyNoRole.
  ///
  /// In ko, this message translates to:
  /// **'직무 미지정'**
  String get historyNoRole;

  /// No description provided for @interviewExit.
  ///
  /// In ko, this message translates to:
  /// **'저장하고 나가기'**
  String get interviewExit;

  /// No description provided for @settingsAppearance.
  ///
  /// In ko, this message translates to:
  /// **'화면 모드'**
  String get settingsAppearance;

  /// No description provided for @settingsAppearanceSystem.
  ///
  /// In ko, this message translates to:
  /// **'시스템 설정'**
  String get settingsAppearanceSystem;

  /// No description provided for @settingsAppearanceLight.
  ///
  /// In ko, this message translates to:
  /// **'라이트'**
  String get settingsAppearanceLight;

  /// No description provided for @settingsAppearanceDark.
  ///
  /// In ko, this message translates to:
  /// **'다크'**
  String get settingsAppearanceDark;

  /// No description provided for @homeFreeTitle.
  ///
  /// In ko, this message translates to:
  /// **'무료 체험'**
  String get homeFreeTitle;

  /// No description provided for @homeFreeRemaining.
  ///
  /// In ko, this message translates to:
  /// **'{remaining}회 남음'**
  String homeFreeRemaining(int remaining);

  /// No description provided for @homeFreeNote.
  ///
  /// In ko, this message translates to:
  /// **'5문항 면접 · 자정 초기화 없음'**
  String get homeFreeNote;

  /// No description provided for @homeProTitle.
  ///
  /// In ko, this message translates to:
  /// **'Pro · 무제한'**
  String get homeProTitle;

  /// No description provided for @homeProRenewal.
  ///
  /// In ko, this message translates to:
  /// **'{date} 갱신'**
  String homeProRenewal(String date);

  /// No description provided for @homeProNoRenewal.
  ///
  /// In ko, this message translates to:
  /// **'기간 만료 후 무료로 전환돼요'**
  String get homeProNoRenewal;

  /// No description provided for @homeFreeExhausted.
  ///
  /// In ko, this message translates to:
  /// **'무료 체험을 모두 사용했어요'**
  String get homeFreeExhausted;

  /// No description provided for @lastFreeTitle.
  ///
  /// In ko, this message translates to:
  /// **'마지막 무료 면접이에요'**
  String get lastFreeTitle;

  /// No description provided for @lastFreeBody.
  ///
  /// In ko, this message translates to:
  /// **'이번 면접이 끝나면 Pro로 계속할 수 있어요.'**
  String get lastFreeBody;

  /// No description provided for @lastFreeStart.
  ///
  /// In ko, this message translates to:
  /// **'시작하기'**
  String get lastFreeStart;

  /// No description provided for @presetLockedTitle.
  ///
  /// In ko, this message translates to:
  /// **'Pro 전용 길이예요'**
  String get presetLockedTitle;

  /// No description provided for @presetLockedBody.
  ///
  /// In ko, this message translates to:
  /// **'무료 체험은 빠른 연습으로 진행돼요. Pro로 바꾸면 더 길게 연습할 수 있어요.'**
  String get presetLockedBody;

  /// No description provided for @reportUpsellTitle.
  ///
  /// In ko, this message translates to:
  /// **'무료 체험을 모두 사용했어요'**
  String get reportUpsellTitle;

  /// No description provided for @reportUpsellBody.
  ///
  /// In ko, this message translates to:
  /// **'Pro로 무제한 이어가기'**
  String get reportUpsellBody;

  /// No description provided for @reportUpsellPrice.
  ///
  /// In ko, this message translates to:
  /// **'월 9,900원'**
  String get reportUpsellPrice;

  /// No description provided for @paywallTitle.
  ///
  /// In ko, this message translates to:
  /// **'Pacer Pro'**
  String get paywallTitle;

  /// No description provided for @paywallHeadline.
  ///
  /// In ko, this message translates to:
  /// **'면접 연습, 횟수 걱정 없이'**
  String get paywallHeadline;

  /// No description provided for @paywallSubhead.
  ///
  /// In ko, this message translates to:
  /// **'무료 체험 2회로는 부족했다면'**
  String get paywallSubhead;

  /// No description provided for @paywallBenefitUnlimited.
  ///
  /// In ko, this message translates to:
  /// **'면접 무제한'**
  String get paywallBenefitUnlimited;

  /// No description provided for @paywallBenefitUnlimitedNote.
  ///
  /// In ko, this message translates to:
  /// **'매일 새로운 공고로 계속 연습'**
  String get paywallBenefitUnlimitedNote;

  /// No description provided for @paywallBenefitLength.
  ///
  /// In ko, this message translates to:
  /// **'5 · 10 · 15문항 선택'**
  String get paywallBenefitLength;

  /// No description provided for @paywallBenefitLengthNote.
  ///
  /// In ko, this message translates to:
  /// **'실전만큼 길게, 심층까지'**
  String get paywallBenefitLengthNote;

  /// No description provided for @paywallBenefitReport.
  ///
  /// In ko, this message translates to:
  /// **'전체 리포트와 모범답안'**
  String get paywallBenefitReport;

  /// No description provided for @paywallBenefitReportNote.
  ///
  /// In ko, this message translates to:
  /// **'질문마다 무엇을 고쳐야 하는지'**
  String get paywallBenefitReportNote;

  /// No description provided for @paywallPrice.
  ///
  /// In ko, this message translates to:
  /// **'월 9,900원'**
  String get paywallPrice;

  /// No description provided for @paywallCta.
  ///
  /// In ko, this message translates to:
  /// **'Pro 시작하기'**
  String get paywallCta;

  /// No description provided for @paywallRestore.
  ///
  /// In ko, this message translates to:
  /// **'구매 복원'**
  String get paywallRestore;

  /// No description provided for @paywallRestoreEmpty.
  ///
  /// In ko, this message translates to:
  /// **'복원할 구매가 없어요.'**
  String get paywallRestoreEmpty;

  /// No description provided for @paywallRestoreDone.
  ///
  /// In ko, this message translates to:
  /// **'구독이 복원됐어요.'**
  String get paywallRestoreDone;

  /// No description provided for @paywallDone.
  ///
  /// In ko, this message translates to:
  /// **'Pro가 시작됐어요. 이제 무제한으로 연습할 수 있어요.'**
  String get paywallDone;

  /// No description provided for @paywallTermsTitle.
  ///
  /// In ko, this message translates to:
  /// **'구독 안내'**
  String get paywallTermsTitle;

  /// No description provided for @paywallTermsRenewal.
  ///
  /// In ko, this message translates to:
  /// **'월 9,900원 자동 갱신 구독이에요. 기간이 끝나기 24시간 전까지 해지하지 않으면 자동으로 갱신돼요.'**
  String get paywallTermsRenewal;

  /// No description provided for @paywallTermsCancel.
  ///
  /// In ko, this message translates to:
  /// **'해지는 기기의 설정 > 계정 > 구독에서 언제든 할 수 있어요. 해지해도 남은 기간까지는 계속 이용할 수 있어요.'**
  String get paywallTermsCancel;

  /// No description provided for @paywallTermsLinks.
  ///
  /// In ko, this message translates to:
  /// **'이용약관과 개인정보 처리방침에 동의하는 것으로 봅니다.'**
  String get paywallTermsLinks;

  /// No description provided for @paywallTerms.
  ///
  /// In ko, this message translates to:
  /// **'이용약관'**
  String get paywallTerms;

  /// No description provided for @paywallPrivacy.
  ///
  /// In ko, this message translates to:
  /// **'개인정보 처리방침'**
  String get paywallPrivacy;

  /// No description provided for @reportLoadingTitle.
  ///
  /// In ko, this message translates to:
  /// **'면접을 채점하고 있어요'**
  String get reportLoadingTitle;

  /// No description provided for @reportLoadingStep1.
  ///
  /// In ko, this message translates to:
  /// **'대화를 처음부터 다시 읽고 있어요'**
  String get reportLoadingStep1;

  /// No description provided for @reportLoadingStep2.
  ///
  /// In ko, this message translates to:
  /// **'항목별로 점수를 매기고 있어요'**
  String get reportLoadingStep2;

  /// No description provided for @reportLoadingStep3.
  ///
  /// In ko, this message translates to:
  /// **'질문마다 모범답안을 정리하고 있어요'**
  String get reportLoadingStep3;

  /// No description provided for @reportLoadingStep4.
  ///
  /// In ko, this message translates to:
  /// **'거의 다 됐어요'**
  String get reportLoadingStep4;

  /// No description provided for @reportLoadingNote.
  ///
  /// In ko, this message translates to:
  /// **'꼼꼼히 보느라 1~2분 걸려요. 화면을 벗어나도 채점은 계속돼요.'**
  String get reportLoadingNote;

  /// No description provided for @profileEntitlementFree.
  ///
  /// In ko, this message translates to:
  /// **'무료 체험 · {remaining}회 남음'**
  String profileEntitlementFree(int remaining);

  /// No description provided for @introSkip.
  ///
  /// In ko, this message translates to:
  /// **'건너뛰기'**
  String get introSkip;

  /// No description provided for @introNext.
  ///
  /// In ko, this message translates to:
  /// **'다음'**
  String get introNext;

  /// No description provided for @introStart.
  ///
  /// In ko, this message translates to:
  /// **'시작하기'**
  String get introStart;

  /// No description provided for @introBadge1.
  ///
  /// In ko, this message translates to:
  /// **'AI 면접 코치'**
  String get introBadge1;

  /// No description provided for @introTitle1.
  ///
  /// In ko, this message translates to:
  /// **'면접, 혼자\n뛰지 마세요'**
  String get introTitle1;

  /// No description provided for @introBody1.
  ///
  /// In ko, this message translates to:
  /// **'공고만 넣으면 그 회사·직무에 맞춘 실전 면접을 페이서가 함께 뜁니다.'**
  String get introBody1;

  /// No description provided for @introBadge2.
  ///
  /// In ko, this message translates to:
  /// **'맞춤 질문 · 꼬리질문'**
  String get introBadge2;

  /// No description provided for @introTitle2.
  ///
  /// In ko, this message translates to:
  /// **'공고 그대로,\n진짜 면접처럼'**
  String get introTitle2;

  /// No description provided for @introBody2.
  ///
  /// In ko, this message translates to:
  /// **'채용공고를 붙여넣으면 맞춤 질문을 만들고, 답변에 따라 꼬리질문으로 깊게 파고들어요.'**
  String get introBody2;

  /// No description provided for @introBadge3.
  ///
  /// In ko, this message translates to:
  /// **'정량 피드백 · 성장 추적'**
  String get introBadge3;

  /// No description provided for @introTitle3.
  ///
  /// In ko, this message translates to:
  /// **'뛸수록\n빨라지는 페이스'**
  String get introTitle3;

  /// No description provided for @introBody3.
  ///
  /// In ko, this message translates to:
  /// **'항목별로 점수를 매기고, 반복할수록 성장하는 그래프를 보여드려요.'**
  String get introBody3;

  /// No description provided for @introArtQuestion.
  ///
  /// In ko, this message translates to:
  /// **'가장 기억에 남는 프로젝트는?'**
  String get introArtQuestion;

  /// No description provided for @introArtAnswer.
  ///
  /// In ko, this message translates to:
  /// **'상품 상세 리뉴얼로 응답 속도를 절반으로…'**
  String get introArtAnswer;

  /// No description provided for @introArtFollowUp.
  ///
  /// In ko, this message translates to:
  /// **'병목은 어떻게 찾으셨나요?'**
  String get introArtFollowUp;

  /// No description provided for @introArtFollowUpBadge.
  ///
  /// In ko, this message translates to:
  /// **'꼬리질문'**
  String get introArtFollowUpBadge;

  /// No description provided for @profilePlanFree.
  ///
  /// In ko, this message translates to:
  /// **'무료 플랜'**
  String get profilePlanFree;

  /// No description provided for @profilePlanPro.
  ///
  /// In ko, this message translates to:
  /// **'Pacer Pro'**
  String get profilePlanPro;

  /// No description provided for @profileEdit.
  ///
  /// In ko, this message translates to:
  /// **'편집'**
  String get profileEdit;

  /// No description provided for @profileUpsellTitle.
  ///
  /// In ko, this message translates to:
  /// **'횟수 걱정 없이\n마음껏 연습하세요'**
  String get profileUpsellTitle;

  /// No description provided for @profileUpsellBenefit1.
  ///
  /// In ko, this message translates to:
  /// **'면접 무제한'**
  String get profileUpsellBenefit1;

  /// No description provided for @profileUpsellBenefit2.
  ///
  /// In ko, this message translates to:
  /// **'5 · 10 · 15문항 선택'**
  String get profileUpsellBenefit2;

  /// No description provided for @profileUpsellBenefit3.
  ///
  /// In ko, this message translates to:
  /// **'전체 리포트와 모범답안'**
  String get profileUpsellBenefit3;

  /// No description provided for @profileUpsellCta.
  ///
  /// In ko, this message translates to:
  /// **'Pro 시작하기 · 월 9,900원'**
  String get profileUpsellCta;
}

class _AppL10nDelegate extends LocalizationsDelegate<AppL10n> {
  const _AppL10nDelegate();

  @override
  Future<AppL10n> load(Locale locale) {
    return SynchronousFuture<AppL10n>(lookupAppL10n(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppL10nDelegate old) => false;
}

AppL10n lookupAppL10n(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppL10nEn();
    case 'ko':
      return AppL10nKo();
  }

  throw FlutterError(
    'AppL10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
