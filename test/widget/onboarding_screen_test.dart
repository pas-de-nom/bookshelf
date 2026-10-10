import 'package:bookshelf/app.dart';
import 'package:bookshelf/screens/home_screen.dart';
import 'package:bookshelf/providers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../helpers/pump_app.dart';

void main() {
  testWidgets('start button saves the flag and opens the catalog',
      (tester) async {
    final overrides = await testOverrides();
    await tester.pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: const BookShelfApp(initialLocation: '/onboarding'),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
    final container =
        ProviderScope.containerOf(tester.element(find.byType(HomeScreen)));
    expect(
        container.read(sharedPreferencesProvider).getBool('onboarded'), isTrue);
  });
}
