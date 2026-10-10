import 'package:bookshelf/l10n/app_localizations.dart';
import 'package:bookshelf/providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.tabSettings)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Semantics(
              header: true,
              child: Text(l10n.language, style: textTheme.titleMedium)),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            segments: [
              ButtonSegment(value: 'system', label: Text(l10n.systemOption)),
              const ButtonSegment(value: 'en', label: Text('English')),
              const ButtonSegment(value: 'fr', label: Text('Français')),
            ],
            selected: {settings.locale?.languageCode ?? 'system'},
            onSelectionChanged: (selection) {
              final value = selection.first;
              notifier.setLocale(value == 'system' ? null : Locale(value));
            },
          ),
          const SizedBox(height: 24),
          Semantics(
              header: true,
              child: Text(l10n.theme, style: textTheme.titleMedium)),
          const SizedBox(height: 8),
          SegmentedButton<ThemeMode>(
            segments: [
              ButtonSegment(
                  value: ThemeMode.system, label: Text(l10n.systemOption)),
              ButtonSegment(
                  value: ThemeMode.light, label: Text(l10n.themeLight)),
              ButtonSegment(value: ThemeMode.dark, label: Text(l10n.themeDark)),
            ],
            selected: {settings.themeMode},
            onSelectionChanged: (selection) =>
                notifier.setThemeMode(selection.first),
          ),
        ],
      ),
    );
  }
}
