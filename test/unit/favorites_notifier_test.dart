import 'package:bookshelf/providers.dart';
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
  test('loads persisted favorites on build', () async {
    final container = await makeContainer({
      'favorites': ['b01', 'b02']
    });
    expect(container.read(favoritesProvider), {'b01', 'b02'});
  });

  test('toggle adds then persists the id', () async {
    final container = await makeContainer({});
    await container.read(favoritesProvider.notifier).toggle('b04');
    expect(container.read(favoritesProvider), {'b04'});
    final prefs = container.read(sharedPreferencesProvider);
    expect(prefs.getStringList('favorites'), ['b04']);
  });

  test('toggling twice removes the id', () async {
    final container = await makeContainer({});
    final notifier = container.read(favoritesProvider.notifier);
    await notifier.toggle('b04');
    await notifier.toggle('b04');
    expect(container.read(favoritesProvider), isEmpty);
  });
}
