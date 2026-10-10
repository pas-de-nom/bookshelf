// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'BookShelf';

  @override
  String get tabCatalog => 'Catalogue';

  @override
  String get tabSearch => 'Recherche';

  @override
  String get tabFavorites => 'Favoris';

  @override
  String get tabSettings => 'Réglages';

  @override
  String get onboardingTitle => 'Votre bibliothèque de poche';

  @override
  String get onboardingBody =>
      'Parcourez les classiques, gardez vos favoris et découvrez leurs histoires.';

  @override
  String get onboardingStart => 'Commencer';

  @override
  String get searchHint => 'Titre ou auteur';

  @override
  String get sortBy => 'Trier par';

  @override
  String get sortTitle => 'Titre';

  @override
  String get sortRating => 'Note';

  @override
  String get sortYear => 'Année';

  @override
  String get allCategories => 'Tous';

  @override
  String get noResults => 'Aucun livre trouvé';

  @override
  String get noFavorites => 'Aucun favori pour l\'instant';

  @override
  String get addFavorite => 'Ajouter aux favoris';

  @override
  String get removeFavorite => 'Retirer des favoris';

  @override
  String get language => 'Langue';

  @override
  String get theme => 'Thème';

  @override
  String get systemOption => 'Système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String byAuthor(String author) {
    return 'de $author';
  }

  @override
  String yearAndRating(String year, String rating) {
    return '$year · ★ $rating';
  }

  @override
  String get errorLoading => 'Impossible de charger le catalogue';

  @override
  String get retry => 'Réessayer';

  @override
  String get synopsis => 'Résumé';

  @override
  String get bookNotFound => 'Livre introuvable';

  @override
  String favoritesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count favoris',
      one: '1 favori',
      zero: 'Aucun favori',
    );
    return '$_temp0';
  }
}
