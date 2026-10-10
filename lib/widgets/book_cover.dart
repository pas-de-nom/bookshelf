import 'package:flutter/material.dart';

/// Network cover, decoded at display size (cacheWidth) to save memory,
/// fading in once loaded. Only built when scrolled into view (ListView.builder).
class BookCover extends StatelessWidget {
  const BookCover({
    super.key,
    required this.url,
    required this.semanticLabel,
    this.width = 60,
    this.height = 90,
  });

  final String url;
  final String semanticLabel;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final dpr = MediaQuery.devicePixelRatioOf(context);
    final background = Theme.of(context).colorScheme.surfaceContainerHighest;
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: SizedBox(
        width: width,
        height: height,
        child: ColoredBox(
          color: background,
          child: Image.network(
            url,
            fit: BoxFit.cover,
            cacheWidth: (width * dpr).round(),
            semanticLabel: semanticLabel,
            gaplessPlayback: true,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded) {
                return child;
              }
              return AnimatedOpacity(
                opacity: frame == null ? 0 : 1,
                duration: const Duration(milliseconds: 250),
                child: child,
              );
            },
            errorBuilder: (context, error, stackTrace) => const Center(
              child: ExcludeSemantics(child: Icon(Icons.menu_book_outlined)),
            ),
          ),
        ),
      ),
    );
  }
}
