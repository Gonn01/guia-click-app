import 'package:auto_route/auto_route.dart';
import 'package:guia_click/src/auto_route/auth_guard.dart';
import 'package:guia_click/src/auto_route/auto_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')

///
class AppRouter extends RootStackRouter {
  ///
  final AuthGuard authGuard = AuthGuard();

  @override
  RouteType get defaultRouteType =>
      const RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
        // AutoRoute(
        //   path: '/',
        //   page: RouteNothing.page,
        //   guards: [authGuard],
        // ),
        AutoRoute(
          page: RouteAuthController.page,
          path: '/auth-controller',
          children: [
            AutoRoute(
              page: RouteLogin.page,
              path: 'login',
            ),
            AutoRoute(
              page: RouteRegister.page,
              path: 'register',
            ),
          ],
        ),
        AutoRoute(
          page: RouteVideo.page,
          path: '/video',
          initial: true,
        ),
        AutoRoute(
          page: RouteHome.page,
          path: '/home',
        ),
        AutoRoute(
          page: RouteSearch.page,
          path: '/search',
        ),
        AutoRoute(
          page: RouteManual.page,
          path: '/manual',
        ),
        AutoRoute(
          page: RouteFavorites.page,
          path: '/favorites',
        ),
        AutoRoute(
          page: RouteMyCompany.page,
          path: '/my-company',
        ),
        AutoRoute(
          page: RouteCompanyConfiguration.page,
          path: '/company-configuration',
        ),
        AutoRoute(
          page: RouteCreateManual.page,
          path: '/create-manual',
        ),
      ];
}
