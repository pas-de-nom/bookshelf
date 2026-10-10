import 'package:bookshelf/providers.dart';
import 'package:bookshelf/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../helpers/pump_app.dart';

void main() {
  testWidgets('choosing French updates the locale setting', (tester) async {
    await pumpApp(tester, const SettingsScreen());
    await tester.tap(find.text('Français'));
    await tester.pumpAndSettle();
    final container =
        ProviderScope.containerOf(tester.element(find.byType(SettingsScreen)));
    expect(container.read(settingsProvider).locale, const Locale('fr'));
  });
}
