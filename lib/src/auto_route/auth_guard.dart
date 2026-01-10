import 'package:auto_route/auto_route.dart';
import 'package:guia_click/services/local_storage.dart';
import 'package:guia_click/src/auto_route/auto_route.gr.dart';

/// {@template AuthGuard}
/// Guarda de autenticación para proteger las rutas de la aplicación.
/// {@endtemplate}
class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final user = await LocalStorage.getUser();

    if (user != null) {
      // Abortamos ir a /login y lo reemplazamos por /home
      resolver.next(false);
      await router.replace(const RouteHome());
      return;
    }

    resolver.next(); // deja entrar a /login
  }
}
