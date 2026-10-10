// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'BookShelf';

  @override
  String get tabCatalog => 'Catalog';

  @override
  String get tabSearch => 'Search';

  @override
  String get tabFavorites => 'Favorites';

  @override
  String get tabSettings => 'Settings';

  @override
  String get onboardingTitle => 'Your pocket library';

  @override
  String get onboardingBody =>
      'Browse classics, save your favorites and discover their stories.';

  @override
  String get onboardingStart => 'Get started';

  @override
  String get searchHint => 'Title or author';

  @override
  String get sortBy => 'Sort by';

  @override
  String get sortTitle => 'Title';

  @override
  String get sortRating => 'Rating';

  @override
  String get sortYear => 'Year';

  @override
  String get allCategories => 'All';

  @override
  String get noResults => 'No books found';

  @override
  String get noFavorites => 'No favorites yet';

  @override
  String get addFavorite => 'Add to favorites';

  @override
  String get removeFavorite => 'Remove from favorites';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get systemOption => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String byAuthor(String author) {
    return 'by $author';
  }

  @override
  String yearAndRating(String year, String rating) {
    return '$year · ★ $rating';
  }

  @override
  String get errorLoading => 'Could not load the catalog';

  @override
  String get retry => 'Retry';

  @override
  String get synopsis => 'Synopsis';

  @override
  String get bookNotFound => 'Book not found';

  @override
  String favoritesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count favorites',
      one: '1 favorite',
      zero: 'No favorites',
    );
    return '$_temp0';
  }
}
