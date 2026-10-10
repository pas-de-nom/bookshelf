import 'package:bookshelf/l10n/app_localizations.dart';
import 'package:bookshelf/logic/book_filter.dart';
import 'package:bookshelf/providers.dart';
import 'package:bookshelf/widgets/book_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

String _sortLabel(AppLocalizations l10n, BookSort sort) => switch (sort) {
      BookSort.title => l10n.sortTitle,
      BookSort.rating => l10n.sortRating,
      BookSort.year => l10n.sortYear,
    };

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final books = ref.watch(booksProvider);
    final category = useState<String?>(null);
    final sort = useState(BookSort.title);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          PopupMenuButton<BookSort>(
            tooltip: l10n.sortBy,
            icon: const Icon(Icons.sort),
            initialValue: sort.value,
            onSelected: (value) => sort.value = value,
            itemBuilder: (context) => [
              for (final option in BookSort.values)
                PopupMenuItem(
                    value: option, child: Text(_sortLabel(l10n, option))),
            ],
          ),
        ],
      ),
      body: books.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.errorLoading),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => ref.invalidate(booksProvider),
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
        data: (all) {
          final categories = all.map((b) => b.category).toSet().toList()
            ..sort();
          final visible =
              sortBooks(filterByCategory(all, category.value), sort.value);
          return Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(l10n.allCategories),
                        selected: category.value == null,
                        onSelected: (_) => category.value = null,
                      ),
                    ),
                    for (final c in categories)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(c),
                          selected: category.value == c,
                          onSelected: (_) => category.value = c,
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemExtent: BookListItem.extent,
                  itemCount: visible.length,
                  itemBuilder: (context, index) => BookListItem(
                      key: ValueKey(visible[index].id), book: visible[index]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
