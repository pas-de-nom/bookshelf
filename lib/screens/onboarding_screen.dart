import 'package:bookshelf/l10n/app_localizations.dart';
import 'package:bookshelf/providers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ExcludeSemantics(child: Icon(Icons.auto_stories, size: 96)),
              const SizedBox(height: 24),
              Semantics(
                header: true,
                child: Text(l10n.onboardingTitle,
                    style: textTheme.headlineMedium,
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 12),
              Text(l10n.onboardingBody,
                  style: textTheme.bodyLarge, textAlign: TextAlign.center),
              const SizedBox(height: 32),
              FilledButton(
                onPressed: () async {
                  await ref
                      .read(sharedPreferencesProvider)
                      .setBool('onboarded', true);
                  if (context.mounted) {
                    context.go('/');
                  }
                },
                child: Text(l10n.onboardingStart),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
