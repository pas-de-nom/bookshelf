import 'package:bookshelf/data/book_repository.dart';
import 'package:bookshelf/l10n/app_localizations.dart';
import 'package:bookshelf/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Override>> testOverrides(
    [Map<String, Object> prefsValues = const {}]) async {
  SharedPreferences.setMockInitialValues(prefsValues);
  final prefs = await SharedPreferences.getInstance();
  return [
    sharedPreferencesProvider.overrideWithValue(prefs),
    bookRepositoryProvider
        .overrideWithValue(InMemoryBookRepository(latency: Duration.zero)),
  ];
}

Future<void> pumpApp(
  WidgetTester tester,
  Widget child, {
  Map<String, Object> prefsValues = const {},
}) async {
  final overrides = await testOverrides(prefsValues);
  await tester.pumpWidget(
    ProviderScope(
      overrides: overrides,
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: child,
      ),
    ),
  );
}
