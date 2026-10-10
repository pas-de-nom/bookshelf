import 'package:bookshelf/l10n/app_localizations.dart';
import 'package:bookshelf/providers.dart';
import 'package:bookshelf/screens/detail_screen.dart';
import 'package:bookshelf/screens/favorites_screen.dart';
import 'package:bookshelf/screens/home_screen.dart';
import 'package:bookshelf/screens/onboarding_screen.dart';
import 'package:bookshelf/screens/search_screen.dart';
import 'package:bookshelf/screens/settings_screen.dart';
import 'package:bookshelf/widgets/scaffold_with_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

GoRouter createRouter({String initialLocation = '/'}) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/book/:id',
        builder: (context, state) =>
            DetailScreen(bookId: state.pathParameters['id']!),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => ScaffoldWithNav(shell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: '/search',
                builder: (context, state) => const SearchScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: '/favorites',
                builder: (context, state) => const FavoritesScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen()),
          ]),
        ],
      ),
    ],
  );
}

ThemeData _theme(Brightness brightness) => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.indigo,
      brightness: brightness,
    );

class BookShelfApp extends HookConsumerWidget {
  const BookShelfApp({super.key, this.initialLocation = '/'});

  final String initialLocation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router =
        useMemoized(() => createRouter(initialLocation: initialLocation));
    final settings = ref.watch(settingsProvider);
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      routerConfig: router,
      locale: settings.locale,
      themeMode: settings.themeMode,
      theme: _theme(Brightness.light),
      darkTheme: _theme(Brightness.dark),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
