# 📚 BookShelf

[![CI](https://github.com/<your-user>/bookshelf/actions/workflows/ci.yml/badge.svg)](https://github.com/<your-user>/bookshelf/actions/workflows/ci.yml)
![Flutter](https://img.shields.io/badge/Flutter-stable-02569B?logo=flutter)
![Tests](https://img.shields.io/badge/tests-26-brightgreen)
![i18n](https://img.shields.io/badge/i18n-FR%20%7C%20EN-blue)

Application Flutter de catalogue de livres, conçue comme une base **production-ready** : architecture claire, tests à trois niveaux, performance maîtrisée, accessibilité, internationalisation et CI/CD.

## Captures d'écran

| Catalogue | Détail | Favoris | Réglages |
|---|---|---|---|
| ![](docs/screenshots/catalog.png) | ![](docs/screenshots/detail.png) | ![](docs/screenshots/favorites.png) | ![](docs/screenshots/settings.png) |

> Ajouter vos captures dans `docs/screenshots/` (`flutter run`, puis `adb exec-out screencap -p > catalog.png`).

## Fonctionnalités

- 6 écrans : Onboarding, Catalogue, Recherche, Détail, Favoris, Réglages
- Filtre par catégorie, tri (titre / note / année), recherche instantanée
- Favoris persistés, langue (système / EN / FR) et thème (système / clair / sombre) persistés
- Accessibilité : tooltips sur tous les boutons-icônes, `semanticLabel` sur les images, en-têtes sémantiques
- Performance : `ListView.builder` + `itemExtent` (lazy), images décodées à la taille d'affichage (`cacheWidth`) avec fondu, `select()` Riverpod, widgets `const`, `flutter_hooks`

## Architecture

```
lib/
├── main.dart              # point d'entrée, injection SharedPreferences
├── app.dart               # MaterialApp.router, go_router, thèmes
├── providers.dart         # état global (Riverpod) : favoris, réglages, catalogue
├── models/                # Book (immuable)
├── data/                  # BookRepository (abstraction) + implémentation mémoire, FavoritesStore
├── logic/                 # fonctions pures : recherche, filtre, tri
├── screens/               # 6 écrans (HookConsumerWidget)
├── widgets/               # BookTile, BookCover, BookListItem, navigation
└── l10n/                  # ARB EN / FR
```

Flux : `Screen → Provider (Riverpod) → Repository / Store`. La logique métier est dans des fonctions pures, ce qui la rend triviale à tester ; le repository est une interface remplaçable par une API HTTP sans toucher à l'UI.

## Installation

```bash
git clone https://github.com/<your-user>/bookshelf.git
cd bookshelf
flutter create . --project-name bookshelf --platforms=android,ios,linux   # génère les dossiers de plateforme
flutter pub get
flutter gen-l10n
flutter run
```

## Tests

```bash
flutter test                                   # 16 unitaires + 8 widgets
flutter test --coverage                        # rapport lcov
flutter test integration_test -d <device>      # 2 tests d'intégration
```

| Niveau | Quantité | Fichiers |
|---|---|---|
| Unitaires | 16 | `test/unit/` (filtres, favoris, réglages, repository) |
| Widgets | 8 | `test/widget/` |
| Intégration | 2 | `integration_test/app_test.dart` |

## CI/CD

`.github/workflows/ci.yml` exécute à chaque push/PR : vérification du format, `flutter analyze`, tests avec couverture, tests d'intégration (Linux + xvfb) et, sur `main`, la génération d'un APK release téléchargeable dans les artefacts.

## Qualité & performance

- `flutter analyze` sans avertissement (`flutter_lints` + règles `prefer_const_*`)
- Profilage : `flutter run --profile` puis DevTools › Performance (aucune frame > 16 ms attendue au défilement)

## Licence

MIT
