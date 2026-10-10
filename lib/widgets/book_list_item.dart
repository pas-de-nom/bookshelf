import 'package:bookshelf/models/book.dart';
import 'package:bookshelf/providers.dart';
import 'package:bookshelf/widgets/book_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Watches only "is this book a favorite?" via select() so toggling one
/// favorite rebuilds a single tile instead of the whole list.
class BookListItem extends ConsumerWidget {
  const BookListItem({super.key, required this.book});

  final Book book;

  static const double extent = 104;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite =
        ref.watch(favoritesProvider.select((ids) => ids.contains(book.id)));
    return BookTile(
      book: book,
      isFavorite: isFavorite,
      onTap: () => context.push('/book/${book.id}'),
      onToggleFavorite: () =>
          ref.read(favoritesProvider.notifier).toggle(book.id),
    );
  }
}
