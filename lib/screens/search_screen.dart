import 'package:bookshelf/l10n/app_localizations.dart';
import 'package:bookshelf/logic/book_filter.dart';
import 'package:bookshelf/models/book.dart';
import 'package:bookshelf/providers.dart';
import 'package:bookshelf/widgets/book_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchScreen extends HookConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final controller = useTextEditingController();
    final query = useState('');
    final books = ref.watch(booksProvider).valueOrNull ?? const <Book>[];
    final results = useMemoized(
        () => searchBooks(books, query.value), [books, query.value]);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controller,
          onChanged: (value) => query.value = value,
          decoration: InputDecoration(
            hintText: l10n.searchHint,
            border: InputBorder.none,
            prefixIcon: const ExcludeSemantics(child: Icon(Icons.search)),
          ),
        ),
      ),
      body: results.isEmpty
          ? Center(child: Text(l10n.noResults))
          : ListView.builder(
              itemExtent: BookListItem.extent,
              itemCount: results.length,
              itemBuilder: (context, index) => BookListItem(
                  key: ValueKey(results[index].id), book: results[index]),
            ),
    );
  }
}
