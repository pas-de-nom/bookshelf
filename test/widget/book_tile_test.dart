import 'package:bookshelf/data/sample_books.dart';
import 'package:bookshelf/widgets/book_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_app.dart';

void main() {
  testWidgets('shows title, author and favorite tooltip', (tester) async {
    await pumpApp(
      tester,
      Scaffold(
        body: BookTile(
            book: sampleBooks[3],
            isFavorite: false,
            onTap: () {},
            onToggleFavorite: () {}),
      ),
    );
    expect(find.text('Dune'), findsOneWidget);
    expect(find.textContaining('Frank Herbert'), findsOneWidget);
    expect(find.byTooltip('Add to favorites'), findsOneWidget);
  });

  testWidgets('favorite button triggers callback and reflects state',
      (tester) async {
    var toggled = 0;
    await pumpApp(
      tester,
      Scaffold(
        body: BookTile(
            book: sampleBooks[3],
            isFavorite: true,
            onTap: () {},
            onToggleFavorite: () => toggled++),
      ),
    );
    expect(find.byTooltip('Remove from favorites'), findsOneWidget);
    await tester.tap(find.byTooltip('Remove from favorites'));
    expect(toggled, 1);
  });
}
