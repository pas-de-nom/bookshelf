import 'package:bookshelf/models/book.dart';

enum BookSort { title, rating, year }

List<Book> searchBooks(List<Book> books, String query) {
  final q = query.trim().toLowerCase();
  if (q.isEmpty) {
    return books;
  }
  return books
      .where((b) =>
          b.title.toLowerCase().contains(q) ||
          b.author.toLowerCase().contains(q))
      .toList();
}

List<Book> filterByCategory(List<Book> books, String? category) {
  if (category == null) {
    return books;
  }
  return books.where((b) => b.category == category).toList();
}

List<Book> sortBooks(List<Book> books, BookSort sort) {
  final sorted = [...books];
  switch (sort) {
    case BookSort.title:
      sorted.sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    case BookSort.rating:
      sorted.sort((a, b) => b.rating.compareTo(a.rating));
    case BookSort.year:
      sorted.sort((a, b) => a.year.compareTo(b.year));
  }
  return sorted;
}
