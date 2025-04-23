import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:guia_click/constants/colors.dart';
import 'package:guia_click/gen/assets.gen.dart';
import 'package:guia_click/src/auto_route/auto_route.gr.dart';
import 'package:guia_click/widgets/text_with_background.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class PageVideo extends StatelessWidget {
  const PageVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const TextWithBackground(
              text:
                  'Desea ver un video tutorial sobre como usar la aplicacion?',
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        Assets.images.youtube.path,
                        scale: .8,
                      ),
                      const Text(
                        'Ver video',
                        style: TextStyle(
                          color: GCColors.primary,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () async {
                  final preferences = await SharedPreferences.getInstance();
                  await preferences.setBool('tutorial_completed', true);
                  await context.router.replace(const RouteHome());
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'SALTEAR ',
                      style: TextStyle(
                        color: GCColors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: GCColors.primary,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
