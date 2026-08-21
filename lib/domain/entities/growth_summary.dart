import 'interview_session.dart';

/// 성장 지표 한 점 — 완주한 면접 하나.
class GrowthPoint {
  const GrowthPoint({
    required this.sessionId,
    required this.score,
    required this.date,
    required this.interviewType,
    required this.isPass,
  });

  final String sessionId;
  final int score;
  final DateTime date;
  final String interviewType;
  final bool isPass;
}

/// 기록 탭(S42)이 쓰는 집계.
///
/// 서버에 집계 API를 따로 두지 않고 히스토리 목록에서 계산한다 — 목록에 이미
/// 점수·날짜·합불이 다 들어 있고, 베타 규모에서 굳이 엔드포인트를 늘릴 이유가 없다.
/// (연속 연습일도 같은 방식으로 이미 계산 중이다)
class GrowthSummary {
  const GrowthSummary({
    required this.points,
    required this.totalInterviews,
    required this.weeklyCount,
  });

  /// 완주한 면접만, **오래된 것부터**. 차트가 왼→오른쪽으로 흐른다.
  final List<GrowthPoint> points;

  /// 진행 중인 것까지 포함한 전체 면접 수.
  final int totalInterviews;

  /// 최근 7일 안에 시작한 면접 수.
  final int weeklyCount;

  /// 추이를 말하려면 비교 대상이 있어야 한다. 1회로는 "성장"이 성립하지 않는다.
  static const minPointsForTrend = 2;

  bool get hasTrend => points.length >= minPointsForTrend;

  int get latestScore => points.isEmpty ? 0 : points.last.score;

  int get bestScore =>
      points.isEmpty ? 0 : points.map((p) => p.score).reduce((a, b) => a > b ? a : b);

  int get averageScore {
    if (points.isEmpty) return 0;
    final total = points.fold(0, (sum, p) => sum + p.score);
    return (total / points.length).round();
  }

  /// 직전 대비 증감. 비교 대상이 없으면 null — 0으로 내리면 "변화 없음"과 헷갈린다.
  int? get latestDelta {
    if (points.length < 2) return null;
    return points.last.score - points[points.length - 2].score;
  }

  int get passCount => points.where((p) => p.isPass).length;

  static GrowthSummary from(List<InterviewSummary> items, {DateTime? now}) {
    final today = now ?? DateTime.now();
    final weekAgo = today.subtract(const Duration(days: 7));

    final completed =
        items
            .where((item) => item.status == SessionStatus.completed && item.score != null)
            .toList()
          // 목록은 최신순으로 오지만 차트는 오래된 것부터 그린다.
          ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return GrowthSummary(
      points: [
        for (final item in completed)
          GrowthPoint(
            sessionId: item.id,
            score: item.score!,
            date: item.createdAt,
            interviewType: item.interviewType,
            isPass: item.passResult == 'pass',
          ),
      ],
      totalInterviews: items.length,
      weeklyCount: items
          .where((item) => item.createdAt.isAfter(weekAgo))
          .length,
    );
  }
}

/// 점수 → 등급. 리포트에는 없는 개념이라 화면에서만 쓴다.
String scoreGrade(int score) => switch (score) {
  >= 90 => 'A+',
  >= 85 => 'A',
  >= 80 => 'A−',
  >= 75 => 'B+',
  >= 70 => 'B',
  >= 65 => 'B−',
  >= 60 => 'C+',
  >= 50 => 'C',
  _ => 'D',
};
