import 'package:bookshelf/data/sample_books.dart';
import 'package:bookshelf/logic/book_filter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('searchBooks', () {
    test('returns everything for an empty query', () {
      expect(searchBooks(sampleBooks, '  '), sampleBooks);
    });

    test('matches title case-insensitively', () {
      final result = searchBooks(sampleBooks, 'dUnE');
      expect(result.map((b) => b.id), ['b04']);
    });

    test('matches author', () {
      final result = searchBooks(sampleBooks, 'austen');
      expect(result.map((b) => b.title),
          containsAll(['Emma', 'Pride and Prejudice']));
      expect(result.length, 2);
    });

    test('returns empty list when nothing matches', () {
      expect(searchBooks(sampleBooks, 'zzzz'), isEmpty);
    });
  });

  group('filterByCategory', () {
    test('null category keeps all books', () {
      expect(filterByCategory(sampleBooks, null).length, sampleBooks.length);
    });

    test('keeps only the requested category', () {
      final result = filterByCategory(sampleBooks, 'Philosophy');
      expect(result, isNotEmpty);
      expect(result.every((b) => b.category == 'Philosophy'), isTrue);
    });
  });

  group('sortBooks', () {
    test('sorts by rating descending', () {
      final result = sortBooks(sampleBooks, BookSort.rating);
      for (var i = 0; i < result.length - 1; i++) {
        expect(result[i].rating >= result[i + 1].rating, isTrue);
      }
    });

    test('sorts by year ascending and does not mutate input', () {
      final before = [...sampleBooks];
      final result = sortBooks(sampleBooks, BookSort.year);
      expect(result.first.title, 'Meditations');
      expect(sampleBooks, before);
    });
  });
}
