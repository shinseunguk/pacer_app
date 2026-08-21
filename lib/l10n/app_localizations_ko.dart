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
  String get setupLength => '면접 길이';

  @override
  String get setupPresetQuick => '빠른 연습';

  @override
  String get setupPresetStandard => '실전';

  @override
  String get setupPresetDeep => '심층';

  @override
  String setupPresetMinutes(int minutes) {
    return '약 $minutes분';
  }

  @override
  String setupPresetTurns(int turns) {
    return '질문 $turns개 내외';
  }

  @override
  String get setupShowScore => '리포트에 점수 표시';

  @override
  String get setupStart => '면접 시작';

  @override
  String get interviewTitle => '면접 진행';

  @override
  String get interviewWarmUp => '워밍업 · 가볍게 시작해요';

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
  String get interviewCoachName => '페이서';

  @override
  String get interviewRetry => '다시 시도';

  @override
  String get interviewPauseSheetTitle => '면접을 잠시 멈출까요?';

  @override
  String get interviewPauseSheetDesc => '지금까지 대화는 저장돼요. 홈에서 언제든 이어할 수 있어요.';

  @override
  String get interviewContinue => '이어서 진행';

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

  @override
  String get reportFeedbackQuestion => '이 리포트가 도움이 되었나요?';

  @override
  String get reportFeedbackUp => '도움돼요';

  @override
  String get reportFeedbackDown => '아쉬워요';

  @override
  String get reportFeedbackThanks => '의견 고마워요. 평가 품질을 높이는 데 쓸게요.';

  @override
  String get reportFeedbackReasonHint => '어떤 점이 아쉬웠나요? (선택)';

  @override
  String get reportFeedbackSend => '보내기';

  @override
  String get reportFeedbackFailed => '의견을 보내지 못했어요. 잠시 후 다시 시도해주세요.';

  @override
  String get settingsTitle => '설정';

  @override
  String get settingsAccount => '계정';

  @override
  String get settingsLegal => '약관·정책';

  @override
  String get settingsWithdraw => '회원 탈퇴';

  @override
  String get settingsWithdrawConfirmTitle => '정말 탈퇴하시겠어요?';

  @override
  String get settingsWithdrawConfirmBody =>
      '탈퇴하면 면접 기록과 평가가 모두 삭제되고 되돌릴 수 없어요. 입력하신 공고·경력 정보도 지체 없이 파기돼요.';

  @override
  String get settingsWithdrawConfirm => '탈퇴하기';

  @override
  String get settingsWithdrawFailed => '탈퇴하지 못했어요. 잠시 후 다시 시도해주세요.';

  @override
  String get settingsLogoutConfirmTitle => '로그아웃할까요?';

  @override
  String get settingsLogoutConfirmBody =>
      '기록은 그대로 남아 있어요. 다시 로그인하면 이어서 볼 수 있어요.';

  @override
  String get historyNoRole => '직무 미지정';

  @override
  String get interviewExit => '저장하고 나가기';

  @override
  String get settingsAppearance => '화면 모드';

  @override
  String get settingsAppearanceSystem => '시스템 설정';

  @override
  String get settingsAppearanceLight => '라이트';

  @override
  String get settingsAppearanceDark => '다크';

  @override
  String get homeFreeTitle => '무료 체험';

  @override
  String homeFreeRemaining(int remaining) {
    return '$remaining회 남음';
  }

  @override
  String get homeFreeNote => '5문항 면접 · 자정 초기화 없음';

  @override
  String get homeProTitle => 'Pro · 무제한';

  @override
  String homeProRenewal(String date) {
    return '$date 갱신';
  }

  @override
  String get homeProNoRenewal => '기간 만료 후 무료로 전환돼요';

  @override
  String get homeFreeExhausted => '무료 체험을 모두 사용했어요';

  @override
  String get lastFreeTitle => '마지막 무료 면접이에요';

  @override
  String get lastFreeBody => '이번 면접이 끝나면 Pro로 계속할 수 있어요.';

  @override
  String get lastFreeStart => '시작하기';

  @override
  String get presetLockedTitle => 'Pro 전용 길이예요';

  @override
  String get presetLockedBody =>
      '무료 체험은 빠른 연습으로 진행돼요. Pro로 바꾸면 더 길게 연습할 수 있어요.';

  @override
  String get reportUpsellTitle => '무료 체험을 모두 사용했어요';

  @override
  String get reportUpsellBody => 'Pro로 무제한 이어가기';

  @override
  String get reportUpsellPrice => '월 9,900원';

  @override
  String get paywallTitle => 'Pacer Pro';

  @override
  String get paywallHeadline => '면접 연습, 횟수 걱정 없이';

  @override
  String get paywallSubhead => '무료 체험 2회로는 부족했다면';

  @override
  String get paywallBenefitUnlimited => '면접 무제한';

  @override
  String get paywallBenefitUnlimitedNote => '매일 새로운 공고로 계속 연습';

  @override
  String get paywallBenefitLength => '5 · 10 · 15문항 선택';

  @override
  String get paywallBenefitLengthNote => '실전만큼 길게, 심층까지';

  @override
  String get paywallBenefitReport => '전체 리포트와 모범답안';

  @override
  String get paywallBenefitReportNote => '질문마다 무엇을 고쳐야 하는지';

  @override
  String get paywallPrice => '월 9,900원';

  @override
  String get paywallCta => 'Pro 시작하기';

  @override
  String get paywallRestore => '구매 복원';

  @override
  String get paywallRestoreEmpty => '복원할 구매가 없어요.';

  @override
  String get paywallRestoreDone => '구독이 복원됐어요.';

  @override
  String get paywallDone => 'Pro가 시작됐어요. 이제 무제한으로 연습할 수 있어요.';

  @override
  String get paywallTermsTitle => '구독 안내';

  @override
  String get paywallTermsRenewal =>
      '월 9,900원 자동 갱신 구독이에요. 기간이 끝나기 24시간 전까지 해지하지 않으면 자동으로 갱신돼요.';

  @override
  String get paywallTermsCancel =>
      '해지는 기기의 설정 > 계정 > 구독에서 언제든 할 수 있어요. 해지해도 남은 기간까지는 계속 이용할 수 있어요.';

  @override
  String get paywallTermsLinks => '이용약관과 개인정보 처리방침에 동의하는 것으로 봅니다.';

  @override
  String get paywallTerms => '이용약관';

  @override
  String get paywallPrivacy => '개인정보 처리방침';

  @override
  String get reportLoadingTitle => '면접을 채점하고 있어요';

  @override
  String get reportLoadingStep1 => '대화를 처음부터 다시 읽고 있어요';

  @override
  String get reportLoadingStep2 => '항목별로 점수를 매기고 있어요';

  @override
  String get reportLoadingStep3 => '질문마다 모범답안을 정리하고 있어요';

  @override
  String get reportLoadingStep4 => '거의 다 됐어요';

  @override
  String get reportLoadingNote => '꼼꼼히 보느라 1~2분 걸려요. 화면을 벗어나도 채점은 계속돼요.';

  @override
  String profileEntitlementFree(int remaining) {
    return '무료 체험 · $remaining회 남음';
  }

  @override
  String get introSkip => '건너뛰기';

  @override
  String get introNext => '다음';

  @override
  String get introStart => '시작하기';

  @override
  String get introBadge1 => 'AI 면접 코치';

  @override
  String get introTitle1 => '면접, 혼자\n뛰지 마세요';

  @override
  String get introBody1 => '공고만 넣으면 그 회사·직무에 맞춘 실전 면접을 페이서가 함께 뜁니다.';

  @override
  String get introBadge2 => '맞춤 질문 · 꼬리질문';

  @override
  String get introTitle2 => '공고 그대로,\n진짜 면접처럼';

  @override
  String get introBody2 => '채용공고를 붙여넣으면 맞춤 질문을 만들고, 답변에 따라 꼬리질문으로 깊게 파고들어요.';

  @override
  String get introBadge3 => '정량 피드백 · 성장 추적';

  @override
  String get introTitle3 => '뛸수록\n빨라지는 페이스';

  @override
  String get introBody3 => '항목별로 점수를 매기고, 반복할수록 성장하는 그래프를 보여드려요.';

  @override
  String get introArtQuestion => '가장 기억에 남는 프로젝트는?';

  @override
  String get introArtAnswer => '상품 상세 리뉴얼로 응답 속도를 절반으로…';

  @override
  String get introArtFollowUp => '병목은 어떻게 찾으셨나요?';

  @override
  String get introArtFollowUpBadge => '꼬리질문';

  @override
  String get profilePlanFree => '무료 플랜';

  @override
  String get profilePlanPro => 'Pacer Pro';

  @override
  String get profileEdit => '편집';

  @override
  String get profileUpsellTitle => '횟수 걱정 없이\n마음껏 연습하세요';

  @override
  String get profileUpsellBenefit1 => '면접 무제한';

  @override
  String get profileUpsellBenefit2 => '5 · 10 · 15문항 선택';

  @override
  String get profileUpsellBenefit3 => '전체 리포트와 모범답안';

  @override
  String get profileUpsellCta => 'Pro 시작하기 · 월 9,900원';

  @override
  String get historyGrowthTitle => '성장 기록';

  @override
  String get historyGrowthSubtitle => '뛸수록 빨라지는 페이스를 확인하세요';

  @override
  String get historyTabTrend => '추이';

  @override
  String get historyTabSkill => '역량';

  @override
  String get historyStreak => '연속 연습';

  @override
  String historyStreakDays(int days) {
    return '$days일';
  }

  @override
  String get historyTotal => '총 면접';

  @override
  String historyTotalCount(int count) {
    return '$count회';
  }

  @override
  String get historyTrendTitle => '종합 점수 추이';

  @override
  String historyTrendDelta(String delta) {
    return '최근 $delta';
  }

  @override
  String get historyAverage => '평균 점수';

  @override
  String get historyBestGrade => '최고 등급';

  @override
  String get historyPassCount => '합격 예상';

  @override
  String historyPassCountValue(int count) {
    return '$count회';
  }

  @override
  String get historySkillTitle => '최근 면접 · 항목별';

  @override
  String historyWeakest(String label, int score) {
    return '가장 약한 항목은 $label($score)이에요.';
  }

  @override
  String get historyGrowthEmptyTitle => '아직 기록이 없어요';

  @override
  String get historyGrowthEmptyBody => '면접을 2회 이상 완주하면\n성장 추이와 약점 진단을 볼 수 있어요.';

  @override
  String get historyGrowthEmptyCta => '첫 면접 시작하기';

  @override
  String get historyListLabel => '면접 이력';
}
