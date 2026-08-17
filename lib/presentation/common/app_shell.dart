import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';

/// 하단 탭 셸 (시안 `BottomTab`) — 홈 · 기록 · 마이.
class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: context.colors.line)),
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: context.colors.bg,
            indicatorColor: context.colors.accentSoft,
            surfaceTintColor: Colors.transparent,
            labelTextStyle: WidgetStateProperty.resolveWith(
              (states) => TextStyle(
                fontSize: 11,
                fontWeight: states.contains(WidgetState.selected)
                    ? FontWeight.w700
                    : FontWeight.w600,
                color: states.contains(WidgetState.selected)
                    ? context.colors.accent
                    : context.colors.text3,
              ),
            ),
            iconTheme: WidgetStateProperty.resolveWith(
              (states) => IconThemeData(
                size: 24,
                color: states.contains(WidgetState.selected)
                    ? context.colors.accent
                    : context.colors.text3,
              ),
            ),
          ),
          child: NavigationBar(
            height: 64,
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (index) => navigationShell.goBranch(
              index,
              // 이미 선택된 탭을 다시 누르면 그 탭의 첫 화면으로.
              initialLocation: index == navigationShell.currentIndex,
            ),
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.home_outlined),
                selectedIcon: const Icon(Icons.home_rounded),
                label: l10n.tabHome,
              ),
              NavigationDestination(
                icon: const Icon(Icons.bar_chart_outlined),
                selectedIcon: const Icon(Icons.bar_chart_rounded),
                label: l10n.tabHistory,
              ),
              NavigationDestination(
                icon: const Icon(Icons.person_outline),
                selectedIcon: const Icon(Icons.person_rounded),
                label: l10n.tabProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
