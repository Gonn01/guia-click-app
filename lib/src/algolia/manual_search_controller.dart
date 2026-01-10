import 'dart:async';

import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:guia_click/models/manual.dart';
import 'package:guia_click/src/algolia/algolia_config.dart';
import 'package:guia_click/src/algolia/hits_page_manual.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ManualSearchController {
  ManualSearchController({
    this.debounceMs = 300,
  });

  final int debounceMs;

  late final HitsSearcher _searcher;
  late final StreamSubscription<HitsPageManual> _sub;

  Timer? _debounce;

  // Para Favorites: si seteás ids, filtra localmente.
  Set<int>? _allowedIds;

  PagingState<int, Manual> pagingState = PagingState(
    hasNextPage: true,
    isLoading: false,
  );

  void init({
    required String initialQuery,
    required VoidCallback onStateChanged,
  }) {
    _searcher = HitsSearcher(
      applicationID: AlgoliaConfig.applicationID,
      apiKey: AlgoliaConfig.apiKey,
      indexName: AlgoliaConfig.indexName,
    );

    final stream = _searcher.responses.map(HitsPageManual.fromResponse);

    _sub = stream.listen(
      (page) {
        final filtered = _applyAllowedIds(page.items);

        pagingState = pagingState.copyWith(
          pages: page.pageKey == 0
              ? [filtered]
              : [...?pagingState.pages, filtered],
          keys: page.pageKey == 0
              ? [page.pageKey]
              : [...?pagingState.keys, page.pageKey],
          hasNextPage: !page.isLastPage,
          isLoading: false,
          error: null,
        );

        onStateChanged();
      },
      onError: (dynamic error, StackTrace st) {
        debugPrint('ALGOLIA ERROR: $error');
        debugPrintStack(stackTrace: st);

        pagingState = pagingState.copyWith(
          isLoading: false,
          error: error,
        );

        onStateChanged();
      },
    );

    pagingState = pagingState.copyWith(isLoading: true, error: null);
    onStateChanged();

    _searcher.applyState((s) => s.copyWith(query: initialQuery, page: 0));
  }

  void setQuery(String query, VoidCallback onStateChanged) {
    _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: debounceMs), () {
      pagingState = PagingState(hasNextPage: true, isLoading: true);
      onStateChanged();

      _searcher.applyState((s) => s.copyWith(query: query, page: 0));
    });
  }

  void fetchNextPage(VoidCallback onStateChanged) {
    if (pagingState.hasNextPage != true) return;

    final nextPage = (pagingState.keys?.last ?? -1) + 1;
    pagingState = pagingState.copyWith(isLoading: true);
    onStateChanged();

    _searcher.applyState((s) => s.copyWith(page: nextPage));
  }

  /// Set de ids permitidos (Favorites). Filtra localmente.
  void setAllowedIds(Set<int>? ids, VoidCallback onStateChanged) {
    _allowedIds = ids;

    // ✅ snapshot() es método
    final currentQuery = _searcher.snapshot().query ?? '';

    pagingState = PagingState(hasNextPage: true, isLoading: true);
    onStateChanged();

    _searcher.applyState((s) => s.copyWith(query: currentQuery, page: 0));
  }

  List<Manual> _applyAllowedIds(List<Manual> items) {
    final allowed = _allowedIds;
    if (allowed == null || allowed.isEmpty) return items;
    return items.where((m) => allowed.contains(m.id)).toList();
  }

  void dispose() {
    _debounce?.cancel();
    _sub.cancel();
    _searcher.dispose();
  }
}
