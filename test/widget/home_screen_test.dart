import 'package:bookshelf/data/sample_books.dart';
import 'package:bookshelf/screens/home_screen.dart';
import 'package:bookshelf/widgets/book_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_app.dart';

void main() {
  testWidgets('lists books once loaded', (tester) async {
    await pumpApp(tester, const HomeScreen());
    await tester.pumpAndSettle();
    expect(find.byType(BookTile), findsWidgets);
    expect(find.text('1984'), findsOneWidget);
  });

  testWidgets('category chip filters the list', (tester) async {
    await pumpApp(tester, const HomeScreen());
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ChoiceChip, 'Philosophy'));
    await tester.pumpAndSettle();
    final expected =
        sampleBooks.where((b) => b.category == 'Philosophy').length;
    expect(find.byType(BookTile), findsNWidgets(expected));
  });
}
