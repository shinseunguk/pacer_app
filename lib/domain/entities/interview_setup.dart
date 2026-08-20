/// 면접 유형 — Phase A는 일반·압박 2종 (MVP 범위 §2).
enum InterviewType {
  general('general'),
  pressure('pressure');

  const InterviewType(this.value);

  final String value;
}

enum InterviewDifficulty {
  low('low'),
  mid('mid'),
  high('high');

  const InterviewDifficulty(this.value);

  final String value;
}

/// 공고 입력 방식 — URL 파싱은 P1.
enum JobSource {
  paste('paste'),
  template('template');

  const JobSource(this.value);

  final String value;
}

/// 직무 질문 수의 범위. 도입 질문(자기소개·지원동기) 2개는 여기 포함되지 않는다.
/// 서버 `MIN/MAX_QUESTION_COUNT`와 같은 값이다.
const kMinQuestionCount = 5;
const kMaxQuestionCount = 15;
const kDefaultQuestionCount = 10;

/// 면접 시작 전에 붙는 도입 질문 수 (자기소개·지원동기).
const kIntroQuestionCount = 2;

/// 면접 길이 프리셋.
///
/// 사용자는 "기본 질문 몇 개"가 아니라 **얼마나 걸리고 몇 번 답하는지**를 궁금해한다.
/// 그래서 화면에는 `questionCount`를 노출하지 않고 예상 시간과 발화 수만 보여준다.
/// 5문항이라고 쓰면 5개만 받는 것처럼 보이는데 실제로는 12개를 답한다.
enum InterviewPreset {
  /// 무료 사용자가 쓸 수 있는 유일한 프리셋.
  quick(questionCount: 5, minutes: 20),
  standard(questionCount: 10, minutes: 35),
  deep(questionCount: 15, minutes: 55);

  const InterviewPreset({required this.questionCount, required this.minutes});

  /// 직무 질문 수 (도입 질문 제외). 서버로 보내는 값.
  final int questionCount;

  /// 화면에 표시할 예상 소요 시간(분). 실측 전이라 추정치다.
  final int minutes;

  /// 사용자가 실제로 답하게 되는 발화 수.
  /// 도입 2개 + 직무 N개 + 꼬리질문(직무 질문당 평균 1개).
  int get approxTurns => kIntroQuestionCount + questionCount * 2;

  static InterviewPreset fromQuestionCount(int count) {
    return InterviewPreset.values.firstWhere(
      (preset) => preset.questionCount == count,
      orElse: () => InterviewPreset.standard,
    );
  }
}

/// S11~S13에서 모으는 면접 생성 입력.
class InterviewSetup {
  const InterviewSetup({
    this.jobSource = JobSource.paste,
    this.jobPostingText = '',
    this.jobRoleId,
    this.jobRoleName,
    this.customRole,
    this.applicantInfo = '',
    this.interviewType = InterviewType.general,
    this.difficulty = InterviewDifficulty.mid,
    this.questionCount = kDefaultQuestionCount,
    this.showScore = true,
  });

  final JobSource jobSource;
  final String jobPostingText;
  final String? jobRoleId;

  /// 화면 표시용(서버 전송 대상 아님).
  final String? jobRoleName;
  final String? customRole;
  final String applicantInfo;
  final InterviewType interviewType;
  final InterviewDifficulty difficulty;
  final int questionCount;
  final bool showScore;

  /// 공고 붙여넣기면 본문이, 템플릿이면 직무 선택이 있어야 시작할 수 있다.
  bool get isReady => switch (jobSource) {
    JobSource.paste => jobPostingText.trim().isNotEmpty,
    JobSource.template =>
      jobRoleId != null || (customRole?.trim().isNotEmpty ?? false),
  };

  InterviewSetup copyWith({
    JobSource? jobSource,
    String? jobPostingText,
    String? jobRoleId,
    String? jobRoleName,
    String? customRole,
    String? applicantInfo,
    InterviewType? interviewType,
    InterviewDifficulty? difficulty,
    int? questionCount,
    bool? showScore,
  }) {
    return InterviewSetup(
      jobSource: jobSource ?? this.jobSource,
      jobPostingText: jobPostingText ?? this.jobPostingText,
      jobRoleId: jobRoleId ?? this.jobRoleId,
      jobRoleName: jobRoleName ?? this.jobRoleName,
      customRole: customRole ?? this.customRole,
      applicantInfo: applicantInfo ?? this.applicantInfo,
      interviewType: interviewType ?? this.interviewType,
      difficulty: difficulty ?? this.difficulty,
      questionCount: questionCount ?? this.questionCount,
      showScore: showScore ?? this.showScore,
    );
  }

  /// 직무 선택을 지울 때는 copyWith로 null을 넘길 수 없어 별도 헬퍼를 둔다.
  InterviewSetup clearJobRole() {
    return InterviewSetup(
      jobSource: jobSource,
      jobPostingText: jobPostingText,
      applicantInfo: applicantInfo,
      interviewType: interviewType,
      difficulty: difficulty,
      questionCount: questionCount,
      showScore: showScore,
    );
  }
}
