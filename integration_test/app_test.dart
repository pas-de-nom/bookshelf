import 'package:bookshelf/app.dart';
import 'package:bookshelf/data/book_repository.dart';
import 'package:bookshelf/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> launchApp(WidgetTester tester) async {
  SharedPreferences.setMockInitialValues({'onboarded': true});
  final prefs = await SharedPreferences.getInstance();
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        bookRepositoryProvider
            .overrideWithValue(InMemoryBookRepository(latency: Duration.zero)),
      ],
      child: const BookShelfApp(),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('browse, open a book, favorite it, find it in Favorites',
      (tester) async {
    await launchApp(tester);

    await tester.tap(find.text('Dune'));
    await tester.pumpAndSettle();
    expect(find.text('Synopsis'), findsOneWidget);

    await tester.tap(find.byTooltip('Add to favorites'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Remove from favorites'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Favorites'));
    await tester.pumpAndSettle();
    expect(find.text('Dune'), findsOneWidget);
    expect(find.text('1 favorite'), findsOneWidget);
  });

  testWidgets('search finds a book and switching to French translates the UI',
      (tester) async {
    await launchApp(tester);

    await tester.tap(find.text('Search'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'verne');
    await tester.pumpAndSettle();
    expect(find.textContaining('Twenty Thousand Leagues'), findsOneWidget);

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Français'));
    await tester.pumpAndSettle();
    expect(find.text('Réglages'), findsWidgets);
    expect(find.text('Favoris'), findsOneWidget);
  });
}
