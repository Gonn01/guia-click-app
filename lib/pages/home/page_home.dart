// ==========================
// lib/pages/home/page_home.dart
// (refactor usando el mismo controller)
// ==========================
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:guia_click/gen/assets.gen.dart';
import 'package:guia_click/models/manual.dart';
import 'package:guia_click/src/algolia/manual_search_controller.dart';
import 'package:guia_click/src/auto_route/auto_route.gr.dart';
import 'package:guia_click/widgets/gc_search_text_field.dart';
import 'package:guia_click/widgets/text_with_background.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

@RoutePage()
class PageHome extends StatelessWidget {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) => const ViewHome();
}

class ViewHome extends StatefulWidget {
  const ViewHome({super.key});

  @override
  State<ViewHome> createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome> {
  final _searchTextController = TextEditingController();
  late final ManualSearchController _controller;

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
            onTap: () => context.router.push(const RouteFavorites()),
            child: const Icon(Icons.star, color: Colors.amber, size: 35),
          ),
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
            Padding(
              padding: const EdgeInsets.all(8),
              child: GCSearchTextField(controller: _searchTextController),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: PagedListView<int, Manual>(
                  state: _controller.pagingState,
                  fetchNextPage: () =>
                      _controller.fetchNextPage(() => setState(() {})),
                  builderDelegate: PagedChildBuilderDelegate<Manual>(
                    firstPageErrorIndicatorBuilder: (_) => Center(
                        child: Text('Error: ${_controller.pagingState.error}')),
                    noItemsFoundIndicatorBuilder: (_) =>
                        const Center(child: Text('No results found')),
                    itemBuilder: (_, item, __) => GestureDetector(
                      onTap: () =>
                          context.router.push(RouteManual(manualId: item.id)),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
