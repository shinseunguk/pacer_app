import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pacer_app/presentation/providers/app_providers.dart';
import 'package:pacer_app/presentation/providers/theme_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<ProviderContainer> createContainer({
    Map<String, Object> initial = const {},
  }) async {
    SharedPreferences.setMockInitialValues(initial);
    final prefs = await SharedPreferences.getInstance();

    final container = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('저장된 값이 없으면 기기 설정을 따른다', () async {
    final container = await createContainer();

    expect(container.read(themeModeProvider), ThemeMode.system);
  });

  test('고른 모드를 저장하고 즉시 반영한다', () async {
    final container = await createContainer();

    await container.read(themeModeProvider.notifier).select(ThemeMode.light);

    expect(container.read(themeModeProvider), ThemeMode.light);
    expect(
      container.read(sharedPreferencesProvider).getString('pacer.theme_mode'),
      'light',
    );
  });

  test('다시 켜도 고른 모드가 유지된다', () async {
    final container = await createContainer(
      initial: {'pacer.theme_mode': 'dark'},
    );

    expect(container.read(themeModeProvider), ThemeMode.dark);
  });

  test('알 수 없는 값이 저장돼 있으면 시스템으로 되돌린다', () async {
    final container = await createContainer(
      initial: {'pacer.theme_mode': 'sepia'},
    );

    expect(container.read(themeModeProvider), ThemeMode.system);
  });

  test('로그아웃해도 화면 모드는 남는다(세션 플래그와 별도 키)', () async {
    final container = await createContainer(
      initial: {
        'pacer.theme_mode': 'dark',
        'pacer.onboarding_completed': true,
      },
    );

    await container.read(sessionPrefsProvider).clear();

    expect(container.read(themeModeProvider), ThemeMode.dark);
  });
}
