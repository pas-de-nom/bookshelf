import 'package:shared_preferences/shared_preferences.dart';

class FavoritesStore {
  const FavoritesStore(this._prefs);

  static const _key = 'favorites';
  final SharedPreferences _prefs;

  Set<String> load() =>
      (_prefs.getStringList(_key) ?? const <String>[]).toSet();

  Future<void> save(Set<String> ids) =>
      _prefs.setStringList(_key, ids.toList());
}
