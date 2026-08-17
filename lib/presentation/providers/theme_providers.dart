import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_providers.dart';

/// 화면 모드 선택 — 시스템 설정을 따르거나 직접 고정한다.
///
/// 로그아웃·탈퇴로 지워지면 안 되는 취향 설정이라 세션 플래그와 별도 키로 둔다.
const _themeModeKey = 'pacer.theme_mode';

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    final stored = ref.read(sharedPreferencesProvider).getString(_themeModeKey);
    return _fromValue(stored);
  }

  Future<void> select(ThemeMode mode) async {
    state = mode;
    await ref
        .read(sharedPreferencesProvider)
        .setString(_themeModeKey, mode.name);
  }
}

ThemeMode _fromValue(String? value) {
  return switch (value) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    // 저장된 값이 없으면 기기 설정을 따른다.
    _ => ThemeMode.system,
  };
}
