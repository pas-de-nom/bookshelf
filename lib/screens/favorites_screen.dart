import 'package:bookshelf/l10n/app_localizations.dart';
import 'package:bookshelf/providers.dart';
import 'package:bookshelf/widgets/book_list_item.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final ids = ref.watch(favoritesProvider);
    final books = ref.watch(booksProvider).valueOrNull ?? const [];
    final favorites = books.where((b) => ids.contains(b.id)).toList();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.tabFavorites)),
      body: favorites.isEmpty
          ? Center(child: Text(l10n.noFavorites))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(l10n.favoritesCount(favorites.length)),
                ),
                Expanded(
                  child: ListView.builder(
                    itemExtent: BookListItem.extent,
                    itemCount: favorites.length,
                    itemBuilder: (context, index) => BookListItem(
                      key: ValueKey(favorites[index].id),
                      book: favorites[index],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
