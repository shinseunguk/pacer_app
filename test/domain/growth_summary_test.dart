import 'package:flutter_test/flutter_test.dart';
import 'package:pacer_app/domain/entities/growth_summary.dart';
import 'package:pacer_app/domain/entities/interview_session.dart';

InterviewSummary item({
  required String id,
  int? score,
  String? passResult,
  SessionStatus status = SessionStatus.completed,
  required DateTime createdAt,
}) => InterviewSummary(
  id: id,
  role: '백엔드',
  interviewType: 'general',
  status: status,
  score: score,
  passResult: passResult,
  createdAt: createdAt,
);

void main() {
  final now = DateTime.utc(2026, 8, 21);

  group('GrowthSummary', () {
    test('완주한 면접만 점으로 잡고 오래된 것부터 정렬한다', () {
      // 목록은 최신순으로 오지만 차트는 왼→오른쪽으로 흐른다.
      final summary = GrowthSummary.from([
        item(id: 'c', score: 80, createdAt: DateTime.utc(2026, 8, 20)),
        item(
          id: 'b',
          status: SessionStatus.inProgress,
          createdAt: DateTime.utc(2026, 8, 19),
        ),
        item(id: 'a', score: 60, createdAt: DateTime.utc(2026, 8, 18)),
      ], now: now);

      expect(summary.points.map((p) => p.sessionId), ['a', 'c']);
      expect(summary.totalInterviews, 3);
    });

    test('완주 2회 미만이면 추이를 그리지 않는다', () {
      // 1회로는 "성장"이 성립하지 않는다.
      final one = GrowthSummary.from([
        item(id: 'a', score: 70, createdAt: now),
      ], now: now);

      expect(one.hasTrend, isFalse);

      final two = GrowthSummary.from([
        item(id: 'a', score: 70, createdAt: now),
        item(id: 'b', score: 75, createdAt: now),
      ], now: now);

      expect(two.hasTrend, isTrue);
    });

    test('직전 대비 증감을 낸다', () {
      final summary = GrowthSummary.from([
        item(id: 'a', score: 60, createdAt: DateTime.utc(2026, 8, 18)),
        item(id: 'b', score: 72, createdAt: DateTime.utc(2026, 8, 20)),
      ], now: now);

      expect(summary.latestScore, 72);
      expect(summary.latestDelta, 12);
    });

    test('비교 대상이 없으면 증감은 null — 0으로 내리면 "변화 없음"과 헷갈린다', () {
      final summary = GrowthSummary.from([
        item(id: 'a', score: 70, createdAt: now),
      ], now: now);

      expect(summary.latestDelta, isNull);
    });

    test('점수가 떨어지면 음수로 낸다', () {
      final summary = GrowthSummary.from([
        item(id: 'a', score: 80, createdAt: DateTime.utc(2026, 8, 18)),
        item(id: 'b', score: 65, createdAt: DateTime.utc(2026, 8, 20)),
      ], now: now);

      expect(summary.latestDelta, -15);
    });

    test('평균·최고·합격 수를 센다', () {
      final summary = GrowthSummary.from([
        item(id: 'a', score: 60, passResult: 'fail', createdAt: DateTime.utc(2026, 8, 18)),
        item(id: 'b', score: 90, passResult: 'pass', createdAt: DateTime.utc(2026, 8, 19)),
        item(id: 'c', score: 75, passResult: 'pass', createdAt: DateTime.utc(2026, 8, 20)),
      ], now: now);

      expect(summary.averageScore, 75);
      expect(summary.bestScore, 90);
      expect(summary.passCount, 2);
    });

    test('최근 7일 안에 시작한 면접만 이번 주로 센다', () {
      final summary = GrowthSummary.from([
        item(id: 'a', score: 70, createdAt: now.subtract(const Duration(days: 2))),
        item(id: 'b', score: 70, createdAt: now.subtract(const Duration(days: 30))),
      ], now: now);

      expect(summary.weeklyCount, 1);
    });

    test('기록이 없어도 0으로 나누지 않는다', () {
      final summary = GrowthSummary.from([], now: now);

      expect(summary.averageScore, 0);
      expect(summary.bestScore, 0);
      expect(summary.latestDelta, isNull);
      expect(summary.hasTrend, isFalse);
    });
  });

  group('scoreGrade', () {
    test('점수 구간에 맞는 등급을 준다', () {
      expect(scoreGrade(95), 'A+');
      expect(scoreGrade(85), 'A');
      expect(scoreGrade(80), 'A−');
      expect(scoreGrade(70), 'B');
      expect(scoreGrade(30), 'D');
    });
  });
}
