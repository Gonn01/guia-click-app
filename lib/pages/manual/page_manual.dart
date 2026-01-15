import 'package:auto_route/auto_route.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guia_click/pages/manual/bloc/bloc_manuals.dart';
import 'package:guia_click/widgets/gc_dialogs.dart';
import 'package:guia_click/widgets/ld_textfields.dart';
import 'package:guia_click/widgets/rating.dart';

@RoutePage()
class PageManual extends StatelessWidget {
  const PageManual({super.key, required this.manualId});
  final int manualId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BlocManual()..add(BlocManualEventInitialize(manualId)),
      child: const ViewManual(),
    );
  }
}

class ViewManual extends StatelessWidget {
  const ViewManual({super.key});

  static const Color _primaryTeal = Color(0xFF0F7C7D);
  static const Color _fieldBg = Color(0xFFF4F6F8);
  static const Color _textDark = Color(0xFF111827);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: _primaryTeal,
          onPressed: () => context.router.back(),
        ),
        actions: [
          BlocBuilder<BlocManual, BlocManualState>(
            builder: (context, state) {
              final isFav = state.isFavorite;
              return IconButton(
                tooltip: isFav ? 'Quitar favorito' : 'Marcar favorito',
                onPressed: state.manual == null
                    ? null
                    : () {
                        final id = state.manual!.id;
                        if (!isFav) {
                          context.read<BlocManual>().add(
                                BlocManualEventMarkAsFavorite(id),
                              );
                        } else {
                          context.read<BlocManual>().add(
                                BlocManualEventMarkAsUnFavorite(id),
                              );
                        }
                      },
                icon: Icon(
                    isFav ? Icons.star_rounded : Icons.star_border_rounded),
                color: isFav ? Colors.amber : _primaryTeal,
                iconSize: 30,
              );
            },
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<BlocManual, BlocManualState>(
          listener: (context, state) {
            if (state is BlocManualStateSuccessCreatingRating) {
              Navigator.of(context).pop(); // cierra dialog al crear/borrar
            }
          },
          builder: (context, state) {
            final manual = state.manual;

            if (state is BlocManualStateLoading && manual == null) {
              return const Center(child: CircularProgressIndicator());
            }

            // if (state is BlocManualStateError && manual == null) {
            //   return Center(
            //     child: Text(
            //       state.message,
            //       style: const TextStyle(color: _textMuted),
            //     ),
            //   );
            // }

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Imagen principal
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      color: _fieldBg,
                      height: 200,
                      child: Image.network(
                        manual?.image ??
                            'https://ugc.production.linktr.ee/11a42626-18c5-48c0-802f-328d410fedc5_---.png?io=true&size=thumbnail-stack-v1_0',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Center(
                          child:
                              Icon(Icons.broken_image, color: Colors.black26),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Título (chip)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: _primaryTeal.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      manual?.title ?? 'Manual',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: _primaryTeal,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Descripción (card)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _fieldBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      manual?.description ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _textDark,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Pasos
                  const Text(
                    'Pasos',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: _textDark,
                    ),
                  ),
                  const SizedBox(height: 8),

                  ...state.steps.map(
                    (s) => PasoWidget(
                      order: s.order,
                      title: s.title,
                      description: s.description,
                      imageUrl: s.image,
                      primaryTeal: _primaryTeal,
                      fieldBg: _fieldBg,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Mi opinión / Agregar
                  if (state.myRating != null) ...[
                    const Text(
                      'Mi opinión',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: _textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    RatingWidget(
                      rating: state.myRating!,
                      hasDelete: true,
                    ),
                  ] else ...[
                    SizedBox(
                      height: 48,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side:
                              BorderSide(color: _primaryTeal.withOpacity(0.35)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => showDialog<void>(
                          context: context,
                          builder: (_) => BlocProvider.value(
                            value: context.read<BlocManual>(),
                            child: NewWidget(manualId: manual?.id ?? 0),
                          ),
                        ),
                        child: const Text(
                          '+ Agregar opinión',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, color: _primaryTeal),
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 16),

                  // Otras opiniones
                  if (state.ratings.isNotEmpty) ...[
                    const Text(
                      'Otras opiniones',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: _textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...state.ratings.map((r) => RatingWidget(rating: r)),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class NewWidget extends StatefulWidget {
  const NewWidget({required this.manualId, super.key});
  final int manualId;

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  final _controller = TextEditingController();
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return LDDialogs.actionRequest(
      content: Column(
        children: [
          const Text(
            'Calificá el manual',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          LDTextFormFields.description(
            controller: _controller,
            hintText: 'Escribí tu opinión',
            maxLines: 5,
          ),
          const SizedBox(height: 10),
          // tu RatingBar original (lo dejo igual)
          // si querés lo hago consistente visual también
          RatingBar(
            filledIcon: Icons.star,
            emptyIcon: Icons.star_border,
            size: 55,
            onRatingChanged: (value) => _rating = value.toInt(),
          ),
        ],
      ),
      onTapConfirm: () => context.read<BlocManual>().add(
            BlocManualsEventCreateRating(
              rating: _rating,
              comment: _controller.text,
            ),
          ),
      isEnabled: true,
    );
  }
}

class PasoWidget extends StatelessWidget {
  const PasoWidget({
    required this.order,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.primaryTeal,
    required this.fieldBg,
    super.key,
  });

  final int order;
  final String title;
  final String description;
  final String imageUrl;
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
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Paso $order: $title',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 160,
                  width: double.infinity,
                  color: fieldBg,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Center(
                      child: Icon(Icons.broken_image, color: Colors.black26),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
