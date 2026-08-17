// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppL10nKo extends AppL10n {
  AppL10nKo([String locale = 'ko']) : super(locale);

  @override
  String get appName => '페이서';

  @override
  String get appTagline => '면접, 혼자 뛰지 마세요';

  @override
  String get commonNext => '다음';

  @override
  String get commonRetry => '다시 시도';

  @override
  String get commonStart => '시작하기';

  @override
  String get commonCancel => '취소';

  @override
  String get commonConfirm => '확인';

  @override
  String get commonSkip => '건너뛰기';

  @override
  String get commonLoadFailed => '불러오지 못했어요.';

  @override
  String get loginKakao => '카카오로 시작하기';

  @override
  String get loginApple => 'Apple로 시작하기';

  @override
  String get loginDevMock => '테스트 계정으로 계속하기 (dev)';

  @override
  String get loginTermsNotice => '로그인하면 이용약관과 개인정보 처리방침에 동의하게 됩니다.';

  @override
  String get loginFailed => '로그인하지 못했어요. 다시 시도해주세요.';

  @override
  String get onboardingNicknameTitle => '어떻게 불러드릴까요?';

  @override
  String get onboardingNicknameDescription => '면접관이 부를 이름이에요. 나중에 바꿀 수 있어요.';

  @override
  String get onboardingNicknameHint => '닉네임 (2~12자)';

  @override
  String get onboardingNicknameEmpty => '닉네임을 입력해주세요.';

  @override
  String get onboardingNicknameTooLong => '닉네임은 20자까지 입력할 수 있어요.';

  @override
  String get consentTitle => '약관에 동의해주세요';

  @override
  String get consentAll => '전체 동의';

  @override
  String get consentTerms => '[필수] 서비스 이용약관';

  @override
  String get consentPrivacy => '[필수] 개인정보 수집·이용 동의';

  @override
  String get consentLlm => '[필수] 면접 내용의 AI 처리 위탁 동의';

  @override
  String get consentLlmDescription =>
      '입력한 공고·경력·답변은 면접 질문과 평가 생성을 위해 AI 모델로 전송돼요.';

  @override
  String get consentMarketing => '[선택] 마케팅 정보 수신';

  @override
  String get consentRequired => '필수 항목에 모두 동의해야 시작할 수 있어요.';

  @override
  String homeGreeting(String nickname) {
    return '안녕하세요, $nickname님';
  }

  @override
  String homeQuotaRemaining(int remaining) {
    return '오늘 남은 질문 $remaining개';
  }

  @override
  String get homeStartInterview => '새 면접 시작';

  @override
  String get homeRecentTitle => '최근 면접';

  @override
  String get homeHistory => '히스토리';

  @override
  String get homeEmptyHistory => '아직 진행한 면접이 없어요. 첫 면접을 시작해보세요.';

  @override
  String get homeSignOut => '로그아웃';

  @override
  String get prepTitle => '면접 준비';

  @override
  String get prepSourcePaste => '공고 붙여넣기';

  @override
  String get prepSourceTemplate => '직무로 시작';

  @override
  String get prepPostingLabel => '채용 공고';

  @override
  String get prepPostingHint => '주요 업무·자격요건을 붙여넣어 주세요.';

  @override
  String get prepPostingEmpty => '공고 내용을 입력해주세요.';

  @override
  String get prepSelectJob => '직무 선택';

  @override
  String get prepSelectJobEmpty => '직무를 선택하거나 직접 입력해주세요.';

  @override
  String prepSelectedJob(String role) {
    return '선택한 직무: $role';
  }

  @override
  String get jobTitle => '직무 선택';

  @override
  String get jobCustomLabel => '목록에 없다면 직접 입력';

  @override
  String get jobCustomHint => '예: 로봇 소프트웨어';

  @override
  String get jobCustomApply => '직접 입력한 직무 사용';

  @override
  String get applicantTitle => '지원자 정보';

  @override
  String get applicantDescription => '경력·자기소개를 적으면 더 맞춤형 질문이 나와요. (선택)';

  @override
  String get applicantHint => '예: 경력 3년, 결제 시스템 백엔드 개발...';

  @override
  String get setupTitle => '면접 설정';

  @override
  String get setupType => '면접 유형';

  @override
  String get setupTypeGeneral => '일반';

  @override
  String get setupTypePressure => '압박';

  @override
  String get setupDifficulty => '난이도';

  @override
  String get setupDifficultyLow => '쉬움';

  @override
  String get setupDifficultyMid => '보통';

  @override
  String get setupDifficultyHigh => '어려움';

  @override
  String get setupQuestionCount => '기본 질문 수';

  @override
  String setupQuestionCountValue(int count) {
    return '$count문항';
  }

  @override
  String get setupShowScore => '리포트에 점수 표시';

  @override
  String get setupStart => '면접 시작';

  @override
  String get interviewTitle => '면접 진행';

  @override
  String interviewProgress(int current, int total) {
    return '질문 $current/$total';
  }

  @override
  String get interviewInputHint => '답변을 입력하세요';

  @override
  String get interviewSend => '전송';

  @override
  String get interviewSkip => '모르겠습니다';

  @override
  String get interviewSkipped => '모르겠습니다 (미응답)';

  @override
  String get interviewPause => '일시정지';

  @override
  String get interviewPausedNotice => '일시정지된 면접이에요. 이어하기를 누르면 계속됩니다.';

  @override
  String get interviewResume => '이어하기';

  @override
  String get interviewFinish => '면접 종료하고 리포트 보기';

  @override
  String get interviewSendFailed => '전송하지 못했어요. 답변은 그대로 두었으니 다시 시도해주세요.';

  @override
  String get reportTitle => '최종 리포트';

  @override
  String get reportPass => '합격';

  @override
  String get reportFail => '불합격';

  @override
  String get reportScoreHidden => '점수 표시를 꺼둔 면접이에요.';

  @override
  String get reportCriteriaTitle => '항목별 점수';

  @override
  String get reportReasonTitle => '판정 근거';

  @override
  String get reportHome => '홈으로';

  @override
  String get reportTranscript => '대화 전문 보기';

  @override
  String get criterionLogic => '논리';

  @override
  String get criterionJobFit => '직무 적합';

  @override
  String get criterionStructure => '답변 구조';

  @override
  String get criterionKeyword => '전문성';

  @override
  String get historyTitle => '히스토리';

  @override
  String get historyEmpty => '아직 기록이 없어요. 첫 면접을 시작해보세요.';

  @override
  String get historyInProgress => '진행 중';

  @override
  String get transcriptTitle => '대화 전문';

  @override
  String get transcriptModelAnswer => '모범답안';

  @override
  String get legalTitle => '약관';

  @override
  String legalVersion(String version, String date) {
    return '버전 $version · 시행일 $date';
  }

  @override
  String get legalView => '보기';

  @override
  String get loginSubcopy => '면접 이력과 성장 추이는 계정에 안전하게 저장돼요.';

  @override
  String get loginNoticeTerms => '계속하면 이용약관 및 개인정보 처리방침에 동의하는 것으로 간주됩니다.';

  @override
  String get loginNoticeAi => '입력한 내용은 AI 분석을 위해 전송돼요.';

  @override
  String get legalTerms => '이용약관';

  @override
  String get legalPrivacy => '개인정보 처리방침';

  @override
  String get homeSubcopy => '오늘도 한 발 앞서 준비해볼까요?';

  @override
  String get homeStreak => '연속 연습';

  @override
  String homeStreakDays(int days) {
    return '$days일';
  }

  @override
  String get homeQuotaTitle => '오늘 기본 질문';

  @override
  String get homeQuotaNote => '꼬리질문 미차감 · 자정 초기화';

  @override
  String get homeHeroBadge => '준비됐나요?';

  @override
  String get homeHeroTitle => '새 면접 시작하기';

  @override
  String get homeHeroSubtitle => '공고를 넣고 맞춤 면접을 뛰어보세요';

  @override
  String get homeHeroAction => '공고 입력';

  @override
  String get homeSectionRecent => '최근 면접';

  @override
  String get homeSeeAll => '전체 보기';

  @override
  String get tabHome => '홈';

  @override
  String get tabHistory => '기록';

  @override
  String get tabProfile => '마이';

  @override
  String get onboardingNicknameRule => '한글·영문·숫자·이모지로 2~12자';

  @override
  String get onboardingNicknameTaken => '이미 사용 중인 닉네임이에요.';

  @override
  String get profileEditNickname => '닉네임 수정';

  @override
  String get commonSave => '저장';

  @override
  String get profileNicknameChanged => '닉네임을 바꿨어요.';
}
