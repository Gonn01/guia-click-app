// ==========================
// lib/src/algolia/hits_page_manual.dart
// ==========================
import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:guia_click/models/manual.dart';

class HitsPageManual {
  final List<Manual> items;
  final int pageKey;
  final int? nextPageKey;
  final bool isLastPage;

  const HitsPageManual(
    this.items,
    this.pageKey,
    this.nextPageKey,
    this.isLastPage,
  );

  factory HitsPageManual.fromResponse(SearchResponse response) {
    // ✅ Evita depender de propiedades de Hit (cambian por versión).
    final rawHits = (response.raw['hits'] as List?) ?? const <dynamic>[];

    final items = rawHits
        .whereType<Map>()
        .map((m) => Map<String, dynamic>.from(m))
        .map(Manual.fromJson)
        .toList();

    final isLastPage = response.page + 1 >= response.nbPages;
    final nextPageKey = isLastPage ? null : response.page + 1;

    return HitsPageManual(items, response.page, nextPageKey, isLastPage);
  }
}
