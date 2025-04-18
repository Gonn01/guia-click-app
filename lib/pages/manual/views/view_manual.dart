import 'package:auto_route/auto_route.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guia_click/pages/manual/bloc/bloc_manuals.dart';
import 'package:guia_click/widgets/rating.dart';
import 'package:guia_click/widgets/text_with_background.dart';

class ViewManual extends StatelessWidget {
  const ViewManual({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffEAEAEA),
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => context.router.back(),
            child: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: BlocBuilder<BlocManual, BlocManualState>(
          builder: (context, state) {
            print(state.isFavorite);
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Image.network(
                    'https://ugc.production.linktr.ee/11a42626-18c5-48c0-802f-328d410fedc5_---.png?io=true&size=thumbnail-stack-v1_0',
                    fit: BoxFit.fitWidth,
                    height: 200,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextWithBackground(
                          margin: EdgeInsets.zero,
                          text: state.manual?.title ?? 'Manual Title',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (!state.isFavorite) {
                            context.read<BlocManual>().add(
                                  BlocManualEventMarkAsFavorite(
                                    state.manual?.id ?? 0,
                                  ),
                                );
                          } else {
                            context.read<BlocManual>().add(
                                  BlocManualEventMarkAsUnFavorite(
                                    state.manual?.id ?? 0,
                                  ),
                                );
                          }
                        },
                        child: RatingBar.readOnly(
                          filledIcon: Icons.star,
                          emptyIcon: Icons.star_border,
                          maxRating: 1,
                          size: 55,
                          initialRating: state.isFavorite ? 1 : 0,
                          filledColor: Colors.yellow,
                        ),
                      ),
                    ],
                  ),
                ),
                TextWithBackground(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  text: state.manual?.description ?? 'Description',
                  textColor: Colors.black,
                  backgroundColor: Colors.white,
                  fontSize: 15,
                ),
                const TextWithBackground(
                  text: 'Pasos',
                ),
                ...state.steps.map(
                  (step) => PasoWidget(
                    order: step.order,
                    title: step.title,
                    description: step.description,
                    imageUrl: step.image,
                  ),
                ),
                if (state.myRating != null)
                  Column(
                    children: [
                      const Row(
                        children: [
                          Expanded(
                            child: TextWithBackground(text: 'Mi opinion'),
                          ),
                        ],
                      ),
                      RatingWidget(rating: state.myRating!),
                    ],
                  )
                else
                  const TextWithBackground(text: '+ Agregar opinión'),
                if (state.ratings.isNotEmpty)
                  const TextWithBackground(text: 'Otras opiniones'),
                ...state.ratings.map(
                  (rating) => RatingWidget(rating: rating),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class PasoWidget extends StatelessWidget {
  const PasoWidget({
    required this.order,
    required this.title,
    required this.description,
    required this.imageUrl,
    super.key,
  });
  final int order;
  final String title;
  final String description;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Paso $order: $title',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
