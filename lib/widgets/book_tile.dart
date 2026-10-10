import 'package:bookshelf/l10n/app_localizations.dart';
import 'package:bookshelf/models/book.dart';
import 'package:bookshelf/widgets/book_cover.dart';
import 'package:flutter/material.dart';

class BookTile extends StatelessWidget {
  const BookTile({
    super.key,
    required this.book,
    required this.isFavorite,
    required this.onTap,
    required this.onToggleFavorite,
  });

  final Book book;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListTile(
      onTap: onTap,
      isThreeLine: true,
      leading: BookCover(url: book.coverUrl, semanticLabel: book.title),
      title: Text(book.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        '${l10n.byAuthor(book.author)}\n'
        '${l10n.yearAndRating(book.year.toString(), book.rating.toStringAsFixed(1))}',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        tooltip: isFavorite ? l10n.removeFavorite : l10n.addFavorite,
        onPressed: onToggleFavorite,
        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
      ),
    );
  }
}
