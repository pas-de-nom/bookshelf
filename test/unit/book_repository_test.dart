import 'package:bookshelf/data/book_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final repository = InMemoryBookRepository(latency: Duration.zero);

  test('fetchBooks returns the catalog', () async {
    final books = await repository.fetchBooks();
    expect(books.length, greaterThanOrEqualTo(10));
  });

  test('findById returns the matching book', () async {
    final book = await repository.findById('b04');
    expect(book?.title, 'Dune');
  });

  test('findById returns null for an unknown id', () async {
    expect(await repository.findById('nope'), isNull);
  });

  test('book ids are unique', () async {
    final books = await repository.fetchBooks();
    expect(books.map((b) => b.id).toSet().length, books.length);
  });
}
