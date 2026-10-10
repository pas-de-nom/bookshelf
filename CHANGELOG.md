# Changelog

All notable changes to this project are documented here.
Format based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), versioning follows [SemVer](https://semver.org/).

## [1.0.0] - 2026-10-10
### Added
- Onboarding, Settings (language + theme), Favorites and Detail screens (6 screens total).
- 16 unit tests, 8 widget tests, 2 integration tests.
- GitHub Actions CI: format check, `flutter analyze`, tests with coverage, Linux integration tests, release APK artifact.
- French and English localization (ARB files, plural support).
- Semantics: tooltips on icon buttons, image semantic labels, header semantics.
### Changed
- List items watch a single favorite flag via `select()` to avoid list-wide rebuilds.
- Fixed-extent lists (`itemExtent`) and cover images decoded at display size (`cacheWidth`).

## [0.2.0] - 2026-10-03
### Added
- Search screen with live filtering by title/author.
- Favorites persisted with `shared_preferences`.
- Category filter chips and sort menu (title, rating, year).
### Fixed
- Catalog list no longer rebuilds fully when toggling a favorite.

## [0.1.0] - 2026-09-26
### Added
- Initial project: Riverpod + go_router architecture.
- Book model, repository abstraction and in-memory catalog.
- Catalog and detail screens.
