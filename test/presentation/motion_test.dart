import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pacer_app/core/theme/app_motion.dart';
import 'package:pacer_app/presentation/common/motion.dart';

const _marker = Text('내용', textDirection: TextDirection.ltr);

Widget _wrap(Widget child, {required bool disableAnimations}) {
  return MediaQuery(
    data: MediaQueryData(disableAnimations: disableAnimations),
    child: Directionality(textDirection: TextDirection.ltr, child: child),
  );
}

void main() {
  group('동작 줄이기가 켜져 있으면', () {
    testWidgets('rise는 모션 없이 내용만 그린다', (tester) async {
      await tester.pumpWidget(
        _wrap(const RiseIn(child: _marker), disableAnimations: true),
      );

      expect(find.text('내용'), findsOneWidget);
      expect(find.byType(TweenAnimationBuilder<double>), findsNothing);
    });

    testWidgets('pop은 모션 없이 내용만 그린다', (tester) async {
      await tester.pumpWidget(
        _wrap(const PopIn(child: _marker), disableAnimations: true),
      );

      expect(find.text('내용'), findsOneWidget);
      expect(find.byType(TweenAnimationBuilder<double>), findsNothing);
    });

    testWidgets('bubble은 모션 없이 내용만 그린다', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const BubbleIn(fromLeft: true, child: _marker),
          disableAnimations: true,
        ),
      );

      expect(find.text('내용'), findsOneWidget);
      expect(find.byType(TweenAnimationBuilder<double>), findsNothing);
    });
  });

  group('동작 줄이기가 꺼져 있으면', () {
    testWidgets('rise는 아래에서 올라오며 나타난다', (tester) async {
      await tester.pumpWidget(
        _wrap(const RiseIn(child: _marker), disableAnimations: false),
      );

      // 시작 프레임: 투명하고 riseOffset만큼 아래에 있다.
      await tester.pump();
      expect(tester.widget<Opacity>(find.byType(Opacity)).opacity, 0);
      expect(_translationOf(tester).dy, AppMotion.riseOffset);

      // 끝나면 제자리에서 불투명해진다.
      await tester.pumpAndSettle();
      expect(tester.widget<Opacity>(find.byType(Opacity)).opacity, 1);
      expect(_translationOf(tester).dy, 0);
    });

    testWidgets('order가 클수록 늦게 시작한다', (tester) async {
      await tester.pumpWidget(
        _wrap(const RiseIn(order: 3, child: _marker), disableAnimations: false),
      );

      // 지연 구간에서는 아직 움직이지 않는다.
      await tester.pump(AppMotion.stagger);
      expect(tester.widget<Opacity>(find.byType(Opacity)).opacity, 0);

      await tester.pumpAndSettle();
      expect(tester.widget<Opacity>(find.byType(Opacity)).opacity, 1);
    });

    testWidgets('bubble은 말하는 쪽에서 밀려 들어온다', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const BubbleIn(fromLeft: true, child: _marker),
          disableAnimations: false,
        ),
      );
      await tester.pump();
      expect(_translationOf(tester).dx, -AppMotion.bubbleOffset);

      await tester.pumpWidget(
        _wrap(
          const BubbleIn(fromLeft: false, child: _marker),
          disableAnimations: false,
        ),
      );
      await tester.pump();
      expect(_translationOf(tester).dx, AppMotion.bubbleOffset);
    });

    testWidgets('enabled가 false면 재생하지 않는다', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const BubbleIn(fromLeft: true, enabled: false, child: _marker),
          disableAnimations: false,
        ),
      );

      expect(find.byType(TweenAnimationBuilder<double>), findsNothing);
    });

    testWidgets('pop은 작게 시작해 제 크기로 커진다', (tester) async {
      await tester.pumpWidget(
        _wrap(const PopIn(child: _marker), disableAnimations: false),
      );

      await tester.pump();
      expect(_scaleOf(tester), closeTo(AppMotion.popScale, 0.001));

      await tester.pumpAndSettle();
      expect(_scaleOf(tester), closeTo(1, 0.001));
    });
  });
}

Offset _translationOf(WidgetTester tester) {
  final transform = tester.widget<Transform>(find.byType(Transform)).transform;
  return Offset(transform.getTranslation().x, transform.getTranslation().y);
}

/// x축 배율만 읽는다 — getMaxScaleOnAxis는 z축(항상 1)이 섞여 축소를 못 잡는다.
double _scaleOf(WidgetTester tester) =>
    tester.widget<Transform>(find.byType(Transform)).transform.storage[0];
