import 'package:bookshelf/l10n/app_localizations.dart';
import 'package:bookshelf/providers.dart';
import 'package:bookshelf/widgets/book_cover.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({super.key, required this.bookId});

  final String bookId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final book = ref.watch(bookByIdProvider(bookId));
    final isFavorite =
        ref.watch(favoritesProvider.select((ids) => ids.contains(bookId)));

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            tooltip: isFavorite ? l10n.removeFavorite : l10n.addFavorite,
            onPressed: () =>
                ref.read(favoritesProvider.notifier).toggle(bookId),
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
          ),
        ],
      ),
      body: book.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(l10n.errorLoading)),
        data: (b) {
          if (b == null) {
            return Center(child: Text(l10n.bookNotFound));
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: BookCover(
                    url: b.coverUrl,
                    semanticLabel: b.title,
                    width: 200,
                    height: 300),
              ),
              const SizedBox(height: 16),
              Semantics(
                  header: true,
                  child: Text(b.title, style: textTheme.headlineSmall)),
              Text(l10n.byAuthor(b.author), style: textTheme.titleMedium),
              Text(l10n.yearAndRating(
                  b.year.toString(), b.rating.toStringAsFixed(1))),
              const SizedBox(height: 16),
              Semantics(
                  header: true,
                  child: Text(l10n.synopsis, style: textTheme.titleMedium)),
              const SizedBox(height: 4),
              Text(b.synopsis),
            ],
          );
        },
      ),
    );
  }
}
