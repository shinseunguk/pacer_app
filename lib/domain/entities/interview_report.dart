/// 평가 항목 점수 (logic / job_fit / structure / keyword).
class CriterionScore {
  const CriterionScore({
    required this.criterion,
    required this.score,
    required this.weight,
  });

  final String criterion;
  final int score;
  final double weight;
}

/// 최종 리포트 (S30). `showScore=false`여도 합불·근거는 제공된다.
class InterviewReport {
  const InterviewReport({
    required this.overallScore,
    required this.showScore,
    required this.passResult,
    required this.passReason,
    required this.weightPreset,
    required this.scores,
  });

  final int overallScore;
  final bool showScore;
  final String passResult;
  final String passReason;
  final String weightPreset;
  final List<CriterionScore> scores;

  bool get isPass => passResult == 'pass';
}
