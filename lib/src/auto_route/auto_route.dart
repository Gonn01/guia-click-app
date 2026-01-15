import 'package:auto_route/auto_route.dart';
import 'package:guia_click/src/auto_route/auth_guard.dart';
import 'package:guia_click/src/auto_route/auto_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')

///
class AppRouter extends RootStackRouter {
  ///
  final AuthGuard authGuard = AuthGuard();

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: RouteLogin.page,
          path: '/login',
          initial: true,
          guards: [authGuard],
        ),
        AutoRoute(
          page: RouteRegister.page,
          path: '/register',
        ),
        AutoRoute(
          page: RouteHome.page,
          path: '/home',
        ),
        AutoRoute(
          page: RouteManual.page,
          path: '/manual',
        ),
        AutoRoute(
          page: RouteFavorites.page,
          path: '/favorites',
        ),
      ];
}
