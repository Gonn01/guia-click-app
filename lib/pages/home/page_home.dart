import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:guia_click/gen/assets.gen.dart';
import 'package:guia_click/models/manual.dart';
import 'package:guia_click/src/auto_route/auto_route.gr.dart';
import 'package:guia_click/widgets/text_with_background.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

@RoutePage()
class PageHome extends StatelessWidget {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const ViewHome();
  }
}

class SearchTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;

  const SearchTextField({
    Key? key,
    this.controller,
    this.hintText = 'Search...',
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF66CFCB), // Ajusta según tu color deseado
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
          border: InputBorder.none,
          suffixIcon: const Icon(Icons.search, color: Colors.white),
        ),
      ),
    );
  }
}

class ViewHome extends StatefulWidget {
  const ViewHome({super.key});

  @override
  State<ViewHome> createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome> {
  final TextEditingController _searchTextController = TextEditingController();

  // Initialize the Algolia searcher with your credentials and your index name.
  final HitsSearcher _manualsSearcher = HitsSearcher(
    applicationID: 'IQD8SWQI6A',
    apiKey: 'bdca1a0ef1aa36eb8f91a9cb7725a60e',
    indexName: 'movies_index',
  );

  /// Creates a stream mapping search responses to a page of Manuals.
  Stream<HitsPageManual> get _searchPage =>
      _manualsSearcher.responses.map(HitsPageManual.fromResponse);

  /// Paging state is used for the infinite scrolling list.
  PagingState<int, Manual> _pagingState = PagingState(
    hasNextPage: true,
    isLoading: false,
  );

  @override
  void initState() {
    super.initState();

    // Listen to text changes and trigger a new search; page resets to 0 on new query.
    _searchTextController.addListener(() {
      _manualsSearcher.applyState(
        (state) => state.copyWith(
          query: _searchTextController.text,
          page: 0,
        ),
      );
    });

    // Listen to search responses and update the pagination state.
    _searchPage.listen(
      (page) {
        setState(() {
          _pagingState = _pagingState.copyWith(
            pages: page.pageKey == 0
                ? [page.items]
                : [...?_pagingState.pages, page.items],
            keys: page.pageKey == 0
                ? [page.pageKey]
                : [...?_pagingState.keys, page.pageKey],
            hasNextPage: !page.isLastPage,
            isLoading: false,
          );
        });
      },
      onError: (dynamic error) {
        setState(() => _pagingState = _pagingState.copyWith(error: error));
        print("Error en Algolia: $error");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffEAEAEA),
        appBar: AppBar(
          backgroundColor: const Color(0xffEAEAEA),
          leading: GestureDetector(
            onTap: () => context.router.push(const RouteFavorites()),
            child: const Icon(
              Icons.star,
              color: Colors.amber,
              size: 35,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => context.router.back(),
              icon: const Icon(
                Icons.menu,
                size: 35,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Container(
                  width: 200,
                  height: 200,
                  padding: const EdgeInsets.all(25),
                  decoration: const BoxDecoration(
                    color: Color(0xffACBFC6),
                    borderRadius: BorderRadius.all(Radius.circular(250)),
                  ),
                  child: Image.asset(Assets.images.guiaClickLogo.path),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: SearchTextField(
                controller: _searchTextController,
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: PagedListView<int, Manual>(
                  state: _pagingState,
                  fetchNextPage: () async {
                    _manualsSearcher.applyState(
                      (state) => state.copyWith(
                        page: (_pagingState.keys?.last ?? -1) + 1,
                      ),
                    );
                  },
                  builderDelegate: PagedChildBuilderDelegate<Manual>(
                    noItemsFoundIndicatorBuilder: (_) => const Center(
                      child: Text('No results found'),
                    ),
                    itemBuilder: (_, item, __) => GestureDetector(
                      onTap: () => context.router.push(
                        RouteManual(manualId: 1),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 120,
                              child: Image.network(
                                item.image ?? 'https://via.placeholder.com/100',
                                width: 100,
                                height: 100,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextWithBackground(
                                          margin: EdgeInsets.zero,
                                          text: item.title ?? 'No title',
                                          padding: const EdgeInsets.all(5),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    item.description ?? 'No description',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }
}

/// A simple class to hold search metadata from the Algolia response.
class SearchMetadata {
  final int nbHits;
  const SearchMetadata(this.nbHits);

  factory SearchMetadata.fromResponse(SearchResponse response) =>
      SearchMetadata(response.nbHits);
}

class HitsPageManual {
  final List<Manual> items;
  final int pageKey;
  final int? nextPageKey;
  final bool isLastPage;

  const HitsPageManual(
      this.items, this.pageKey, this.nextPageKey, this.isLastPage);

  factory HitsPageManual.fromResponse(SearchResponse response) {
    final items = response.hits.map(Manual.fromJson).toList();
    final isLastPage = response.page + 1 >= response.nbPages;
    final nextPageKey = isLastPage ? null : response.page + 1;
    return HitsPageManual(items, response.page, nextPageKey, isLastPage);
  }
}
