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

const kMinQuestionCount = 3;
const kMaxQuestionCount = 10;
const kDefaultQuestionCount = 5;

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
