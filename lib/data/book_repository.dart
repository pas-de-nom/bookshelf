import 'package:bookshelf/data/sample_books.dart';
import 'package:bookshelf/models/book.dart';

abstract class BookRepository {
  Future<List<Book>> fetchBooks();
  Future<Book?> findById(String id);
}

/// Simulates a remote API. Swap for an HTTP implementation without touching UI code.
class InMemoryBookRepository implements BookRepository {
  InMemoryBookRepository({this.latency = const Duration(milliseconds: 300)});

  final Duration latency;

  Future<void> _simulateLatency() async {
    if (latency > Duration.zero) {
      await Future<void>.delayed(latency);
    }
  }

  @override
  Future<List<Book>> fetchBooks() async {
    await _simulateLatency();
    return sampleBooks;
  }

  @override
  Future<Book?> findById(String id) async {
    await _simulateLatency();
    for (final book in sampleBooks) {
      if (book.id == id) {
        return book;
      }
    }
    return null;
  }
}
