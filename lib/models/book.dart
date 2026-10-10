import 'package:flutter/foundation.dart';

@immutable
class Book {
  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.year,
    required this.rating,
    required this.synopsis,
  });

  final String id;
  final String title;
  final String author;
  final String category;
  final int year;
  final double rating;
  final String synopsis;

  String get coverUrl => 'https://picsum.photos/seed/$id/400/600';
}
