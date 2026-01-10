import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:guia_click/src/auto_route/auto_route.dart';
import 'package:guia_click/src/localization/app_localizations.dart';

import 'package:guia_click/src/settings/settings_controller.dart';

final appRouter = AppRouter();

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    required this.settingsController,
    super.key,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          debugShowCheckedModeBanner: false,
          routerDelegate: appRouter.delegate(
            navigatorObservers: () => [MyObserver()],
          ),
          routeInformationParser: appRouter.defaultRouteParser(),
        );
      },
    );
  }
}

class MyObserver extends AutoRouterObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final title = route.data;
    print(title?.name);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final title = route.data;
    print(title?.name);
  }
}
