import 'package:bookshelf/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ProviderContainer> makeContainer(Map<String, Object> values) async {
  SharedPreferences.setMockInitialValues(values);
  final prefs = await SharedPreferences.getInstance();
  final container = ProviderContainer(
    overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('defaults to system locale and theme', () async {
    final container = await makeContainer({});
    final state = container.read(settingsProvider);
    expect(state.locale, isNull);
    expect(state.themeMode, ThemeMode.system);
  });

  test('setLocale updates state and persists, null clears it', () async {
    final container = await makeContainer({});
    final notifier = container.read(settingsProvider.notifier);
    await notifier.setLocale(const Locale('fr'));
    expect(container.read(settingsProvider).locale, const Locale('fr'));
    expect(container.read(sharedPreferencesProvider).getString('locale'), 'fr');
    await notifier.setLocale(null);
    expect(
        container.read(sharedPreferencesProvider).getString('locale'), isNull);
  });

  test('setThemeMode persists the mode index', () async {
    final container = await makeContainer({});
    await container
        .read(settingsProvider.notifier)
        .setThemeMode(ThemeMode.dark);
    expect(container.read(settingsProvider).themeMode, ThemeMode.dark);
    expect(container.read(sharedPreferencesProvider).getInt('themeMode'),
        ThemeMode.dark.index);
  });
}
