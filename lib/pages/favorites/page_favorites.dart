import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guia_click/constants/colors.dart';
import 'package:guia_click/models/manual.dart';
import 'package:guia_click/pages/favorites/bloc/bloc_favorites.dart';
import 'package:guia_click/src/algolia/manual_search_controller.dart';
import 'package:guia_click/src/auto_route/auto_route.gr.dart';
import 'package:guia_click/widgets/gc_search_text_field.dart';
import 'package:guia_click/widgets/text_with_background.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

@RoutePage()
class PageFavorites extends StatelessWidget {
  const PageFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BlocFavorites()..add(BlocFavoritesEventInitialize()),
      child: const ViewFavorites(),
    );
  }
}

class ViewFavorites extends StatefulWidget {
  const ViewFavorites({super.key});

  @override
  State<ViewFavorites> createState() => _ViewFavoritesState();
}

class _ViewFavoritesState extends State<ViewFavorites> {
  final _searchTextController = TextEditingController();
  late final ManualSearchController _controller;

  int _lastFavHash = 0;

  @override
  void initState() {
    super.initState();

    _controller = ManualSearchController()
      ..init(
        initialQuery: '',
        onStateChanged: () {
          if (mounted) setState(() {});
        },
      );

    _searchTextController.addListener(() {
      _controller.setQuery(_searchTextController.text, () {
        if (mounted) setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffEAEAEA),
        appBar: AppBar(
          backgroundColor: const Color(0xffEAEAEA),
          leading: GestureDetector(
            onTap: () => context.router.back(),
            child: const Icon(
              Icons.arrow_back,
              color: GCColors.primary,
              size: 35,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: GCSearchTextField(controller: _searchTextController),
            ),

            // ✅ IMPORTANTE: actualizar allowedIds en LISTENER, no en builder.
            Expanded(
              child: BlocConsumer<BlocFavorites, BlocFavoritesState>(
                listenWhen: (prev, curr) =>
                    prev.favoriteManuals != curr.favoriteManuals,
                listener: (context, state) {
                  final favIds = state.favoriteManuals.map((m) => m.id).toList()
                    ..sort();

                  final favHash = Object.hashAll(favIds);
                  if (favHash == _lastFavHash) return;
                  _lastFavHash = favHash;

                  // ✅ Esto puede disparar búsquedas + setState => OK en listener
                  _controller.setAllowedIds(favIds.toSet(), () {
                    if (mounted) setState(() {});
                  });
                },
                builder: (context, state) {
                  if (state.favoriteManuals.isEmpty) {
                    return const Center(
                      child: Text(
                        'No favorites found',
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  }

                  return Container(
                    margin: const EdgeInsets.all(20),
                    child: PagedListView<int, Manual>(
                      state: _controller.pagingState,
                      fetchNextPage: () =>
                          _controller.fetchNextPage(() => setState(() {})),
                      builderDelegate: PagedChildBuilderDelegate<Manual>(
                        firstPageErrorIndicatorBuilder: (_) => Center(
                          child: Text(
                            'Error: ${_controller.pagingState.error}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        newPageErrorIndicatorBuilder: (_) => Center(
                          child: Text(
                            'Error: ${_controller.pagingState.error}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        noItemsFoundIndicatorBuilder: (_) =>
                            const Center(child: Text('No results found')),
                        itemBuilder: (_, item, __) => GestureDetector(
                          onTap: () => context.router
                              .push(RouteManual(manualId: item.id)),
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
                                    item.image,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      width: 100,
                                      height: 100,
                                      alignment: Alignment.center,
                                      color: Colors.black12,
                                      child: const Icon(Icons.broken_image),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWithBackground(
                                        margin: EdgeInsets.zero,
                                        text: item.title,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        fontSize: 15,
                                      ),
                                      const SizedBox(height: 15),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Text(
                                          item.description,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
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
                  );
                },
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
    _controller.dispose();
    super.dispose();
  }
}
