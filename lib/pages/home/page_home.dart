// lib/pages/home/page_home.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guia_click/gen/assets.gen.dart';
import 'package:guia_click/models/manual.dart';
import 'package:guia_click/models/user/isar_user.dart';
import 'package:guia_click/pages/home/bloc/bloc_home.dart';
import 'package:guia_click/services/local_storage.dart';
import 'package:guia_click/src/algolia/manual_search_controller.dart';
import 'package:guia_click/src/auto_route/auto_route.gr.dart';
import 'package:guia_click/widgets/gc_search_text_field.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

@RoutePage()
class PageHome extends StatelessWidget {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BlocHome()
        // 👇 si tu bloc ya carga el user en constructor, podés borrar esto
        ..add(BlocHomeEventInitialize()),
      child: const ViewHome(),
    );
  }
}

class ViewHome extends StatefulWidget {
  const ViewHome({super.key});

  @override
  State<ViewHome> createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome> {
  // Paleta consistente con Login/Register
  static const Color _primaryTeal = Color(0xFF0F7C7D);
  static const Color _fieldBg = Color(0xFFF4F6F8);
  static const Color _textDark = Color(0xFF111827);
  static const Color _textMuted = Color(0xFF6B7280);

  final _searchTextController = TextEditingController();
  late final ManualSearchController _controller;

  @override
  void initState() {
    super.initState();

    // Si preferís inicializar acá en vez de en PageHome:
    // context.read<BlocHome>().add(const BlocHomeInit());

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

  Future<void> _logout(BuildContext context) async {
    await LocalStorage.clearUser();
    await context.router.replace(const RouteLogin());
  }

  Future<void> _goToLogin(BuildContext context) async {
    await context.router.push(const RouteLogin());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leadingWidth: 56,
        leading: IconButton(
          onPressed: () => context.router.push(const RouteFavorites()),
          icon: const Icon(Icons.star_rounded),
          color: _primaryTeal,
          iconSize: 30,
          tooltip: 'Favoritos',
        ),
        actions: [
          BlocSelector<BlocHome, BlocHomeState, User?>(
            selector: (state) => state.user,
            builder: (context, user) {
              return IconButton(
                onPressed: () =>
                    user != null ? _logout(context) : _goToLogin(context),
                icon: Icon(
                  user != null
                      ? Icons.exit_to_app_rounded
                      : Icons.login_rounded,
                ),
                color: user != null ? Colors.red : _primaryTeal,
                iconSize: 30,
                tooltip: user != null ? 'Salir' : 'Iniciar sesión',
              );
            },
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: 86,
                      height: 86,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _primaryTeal.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset(Assets.images.guiaClickLogo.path),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'GuíaClick',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: _textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Buscá un manual y aprendé al toque.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: _textMuted),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: _fieldBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: GCSearchTextField(controller: _searchTextController),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: PagedListView<int, Manual>(
                  state: _controller.pagingState,
                  fetchNextPage: () =>
                      _controller.fetchNextPage(() => setState(() {})),
                  builderDelegate: PagedChildBuilderDelegate<Manual>(
                    firstPageErrorIndicatorBuilder: (_) => Center(
                      child: Text(
                        'Error: ${_controller.pagingState.error}',
                        style: const TextStyle(color: _textMuted),
                      ),
                    ),
                    noItemsFoundIndicatorBuilder: (_) => const Center(
                      child: Text(
                        'No se encontraron resultados',
                        style: TextStyle(color: _textMuted),
                      ),
                    ),
                    itemBuilder: (_, item, __) => _ManualCard(
                      manual: item,
                      onTap: () =>
                          context.router.push(RouteManual(manualId: item.id)),
                      primaryTeal: _primaryTeal,
                      fieldBg: _fieldBg,
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

class _ManualCard extends StatelessWidget {
  const _ManualCard({
    required this.manual,
    required this.onTap,
    required this.primaryTeal,
    required this.fieldBg,
  });

  final Manual manual;
  final VoidCallback onTap;
  final Color primaryTeal;
  final Color fieldBg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        elevation: 1,
        shadowColor: Colors.black12,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: fieldBg,
                    width: 110,
                    height: 86,
                    child: Image.network(
                      manual.image,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Center(
                        child: Icon(Icons.broken_image, color: Colors.black26),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: primaryTeal.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          manual.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: primaryTeal,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        manual.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF111827),
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
    );
  }
}
