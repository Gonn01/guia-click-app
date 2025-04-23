import 'package:auto_route/auto_route.dart';
import 'package:guia_click/src/auto_route/auto_route.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template AuthGuard}
/// Guarda de autenticación para proteger las rutas de la aplicación.
/// {@endtemplate}
class TutorialGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final preferences = await SharedPreferences.getInstance();
    final isTutorialCompleted =
        preferences.getBool('tutorial_completed') ?? false;
    if (!isTutorialCompleted) {
      // Si el tutorial ya se completó, permite la navegación a la ruta solicitada.
      print('Tutorial completado: $isTutorialCompleted');
      resolver.next();
    } else {
      // Si el tutorial no se ha completado, redirige al usuario al tutorial.
      await router.replace(const RouteHome());
      print('Tutorial no completado: $isTutorialCompleted');
      resolver.next(false);
    }
  }
}
