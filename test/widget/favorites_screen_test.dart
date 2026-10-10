import 'package:bookshelf/screens/favorites_screen.dart';
import 'package:bookshelf/widgets/book_tile.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_app.dart';

void main() {
  testWidgets('shows the empty state without favorites', (tester) async {
    await pumpApp(tester, const FavoritesScreen());
    await tester.pumpAndSettle();
    expect(find.text('No favorites yet'), findsOneWidget);
  });

  testWidgets('shows persisted favorites', (tester) async {
    await pumpApp(
      tester,
      const FavoritesScreen(),
      prefsValues: {
        'favorites': ['b04']
      },
    );
    await tester.pumpAndSettle();
    expect(find.byType(BookTile), findsOneWidget);
    expect(find.text('Dune'), findsOneWidget);
    expect(find.text('1 favorite'), findsOneWidget);
  });
}
