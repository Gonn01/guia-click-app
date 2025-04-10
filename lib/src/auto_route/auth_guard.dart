import 'package:auto_route/auto_route.dart';

/// {@template AuthGuard}
/// Guarda de autenticación para proteger las rutas de la aplicación.
/// {@endtemplate}
class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    // final isarUser = await LocalStorage.getUser();
    // final companyData = await LocalStorage.getCompanyData();

    // final isLoggedIn = isarUser != null;
    // final isIdentified = companyData != null;

    // if (isIdentified && isLoggedIn) {
    //   // Usuario identificado pero no logeado: redirige al dashboard.
    //   await router.push(const RouteDashboard());
    // } else if (isIdentified) {
    //   // Usuario identificado pero no logeado: redirige al login.
    //   await router.push(const RouteLogin());
    //   // Opcional: Puedes cancelar la navegación original si es necesario.
    //   // resolver.next(false);
    // } else {
    //   // Usuario no identificado: redirige a la identificación.
    //   await router.push(const RouteIdentification());
    //   // resolver.next(false);
    // }
  }
}
