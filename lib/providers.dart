import 'package:bookshelf/data/book_repository.dart';
import 'package:bookshelf/data/favorites_store.dart';
import 'package:bookshelf/models/book.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) =>
      throw UnimplementedError('Override sharedPreferencesProvider in main()'),
);

final bookRepositoryProvider =
    Provider<BookRepository>((ref) => InMemoryBookRepository());

final booksProvider = FutureProvider<List<Book>>(
  (ref) => ref.watch(bookRepositoryProvider).fetchBooks(),
);

final bookByIdProvider = FutureProvider.family<Book?, String>(
  (ref, id) => ref.watch(bookRepositoryProvider).findById(id),
);

final favoritesStoreProvider = Provider<FavoritesStore>(
  (ref) => FavoritesStore(ref.watch(sharedPreferencesProvider)),
);

class FavoritesNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => ref.watch(favoritesStoreProvider).load();

  Future<void> toggle(String id) async {
    final next = {...state};
    if (!next.remove(id)) {
      next.add(id);
    }
    state = next;
    await ref.read(favoritesStoreProvider).save(next);
  }
}

final favoritesProvider =
    NotifierProvider<FavoritesNotifier, Set<String>>(FavoritesNotifier.new);

@immutable
class SettingsState {
  const SettingsState({this.locale, this.themeMode = ThemeMode.system});

  final Locale? locale;
  final ThemeMode themeMode;
}

class SettingsNotifier extends Notifier<SettingsState> {
  static const _localeKey = 'locale';
  static const _themeKey = 'themeMode';

  @override
  SettingsState build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final code = prefs.getString(_localeKey);
    final stored = prefs.getInt(_themeKey) ?? 0;
    final index = stored >= 0 && stored < ThemeMode.values.length ? stored : 0;
    return SettingsState(
      locale: code == null ? null : Locale(code),
      themeMode: ThemeMode.values[index],
    );
  }

  Future<void> setLocale(Locale? locale) async {
    state = SettingsState(locale: locale, themeMode: state.themeMode);
    final prefs = ref.read(sharedPreferencesProvider);
    if (locale == null) {
      await prefs.remove(_localeKey);
    } else {
      await prefs.setString(_localeKey, locale.languageCode);
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = SettingsState(locale: state.locale, themeMode: mode);
    await ref.read(sharedPreferencesProvider).setInt(_themeKey, mode.index);
  }
}

final settingsProvider =
    NotifierProvider<SettingsNotifier, SettingsState>(SettingsNotifier.new);
