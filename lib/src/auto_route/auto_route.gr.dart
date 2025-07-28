// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;
import 'package:guia_click/pages/company_configuration/page_company_configuration.dart'
    as _i1;
import 'package:guia_click/pages/create_manual/page_create_manual.dart' as _i2;
import 'package:guia_click/pages/favorites/page_favorites.dart' as _i3;
import 'package:guia_click/pages/home/page_home.dart' as _i4;
import 'package:guia_click/pages/auth/login/page_login.dart' as _i5;
import 'package:guia_click/pages/manual/page_manual.dart' as _i6;
import 'package:guia_click/pages/my_company/page_my_company.dart' as _i7;
import 'package:guia_click/pages/auth/register/page_register.dart' as _i9;
import 'package:guia_click/pages/search/page_search.dart' as _i10;
import 'package:guia_click/pages/auth/video/page_video.dart' as _i11;
import 'package:guia_click/src/auto_route/nothing_page.dart' as _i8;

abstract class $AppRouter extends _i12.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    RouteCompanyConfiguration.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.PageCompanyConfiguration(),
      );
    },
    RouteCreateManual.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.PageCreateManual(),
      );
    },
    RouteFavorites.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.PageFavorites(),
      );
    },
    RouteHome.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.PageHome(),
      );
    },
    RouteLogin.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.PageLogin(),
      );
    },
    RouteManual.name: (routeData) {
      final args = routeData.argsAs<RouteManualArgs>();
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.PageManual(
          key: args.key,
          manualId: args.manualId,
        ),
      );
    },
    RouteMyCompany.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.PageMyCompany(),
      );
    },
    RouteNothing.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.PageNothing(),
      );
    },
    RouteRegister.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.PageRegister(),
      );
    },
    RouteSearch.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.PageSearch(),
      );
    },
    RouteVideo.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.PageVideo(),
      );
    },
  };
}

/// generated route for
/// [_i1.PageCompanyConfiguration]
class RouteCompanyConfiguration extends _i12.PageRouteInfo<void> {
  const RouteCompanyConfiguration({List<_i12.PageRouteInfo>? children})
      : super(
          RouteCompanyConfiguration.name,
          initialChildren: children,
        );

  static const String name = 'RouteCompanyConfiguration';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i2.PageCreateManual]
class RouteCreateManual extends _i12.PageRouteInfo<void> {
  const RouteCreateManual({List<_i12.PageRouteInfo>? children})
      : super(
          RouteCreateManual.name,
          initialChildren: children,
        );

  static const String name = 'RouteCreateManual';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i3.PageFavorites]
class RouteFavorites extends _i12.PageRouteInfo<void> {
  const RouteFavorites({List<_i12.PageRouteInfo>? children})
      : super(
          RouteFavorites.name,
          initialChildren: children,
        );

  static const String name = 'RouteFavorites';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i4.PageHome]
class RouteHome extends _i12.PageRouteInfo<void> {
  const RouteHome({List<_i12.PageRouteInfo>? children})
      : super(
          RouteHome.name,
          initialChildren: children,
        );

  static const String name = 'RouteHome';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i5.PageLogin]
class RouteLogin extends _i12.PageRouteInfo<void> {
  const RouteLogin({List<_i12.PageRouteInfo>? children})
      : super(
          RouteLogin.name,
          initialChildren: children,
        );

  static const String name = 'RouteLogin';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i6.PageManual]
class RouteManual extends _i12.PageRouteInfo<RouteManualArgs> {
  RouteManual({
    _i13.Key? key,
    required int manualId,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          RouteManual.name,
          args: RouteManualArgs(
            key: key,
            manualId: manualId,
          ),
          initialChildren: children,
        );

  static const String name = 'RouteManual';

  static const _i12.PageInfo<RouteManualArgs> page =
      _i12.PageInfo<RouteManualArgs>(name);
}

class RouteManualArgs {
  const RouteManualArgs({
    this.key,
    required this.manualId,
  });

  final _i13.Key? key;

  final int manualId;

  @override
  String toString() {
    return 'RouteManualArgs{key: $key, manualId: $manualId}';
  }
}

/// generated route for
/// [_i7.PageMyCompany]
class RouteMyCompany extends _i12.PageRouteInfo<void> {
  const RouteMyCompany({List<_i12.PageRouteInfo>? children})
      : super(
          RouteMyCompany.name,
          initialChildren: children,
        );

  static const String name = 'RouteMyCompany';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i8.PageNothing]
class RouteNothing extends _i12.PageRouteInfo<void> {
  const RouteNothing({List<_i12.PageRouteInfo>? children})
      : super(
          RouteNothing.name,
          initialChildren: children,
        );

  static const String name = 'RouteNothing';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i9.PageRegister]
class RouteRegister extends _i12.PageRouteInfo<void> {
  const RouteRegister({List<_i12.PageRouteInfo>? children})
      : super(
          RouteRegister.name,
          initialChildren: children,
        );

  static const String name = 'RouteRegister';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i10.PageSearch]
class RouteSearch extends _i12.PageRouteInfo<void> {
  const RouteSearch({List<_i12.PageRouteInfo>? children})
      : super(
          RouteSearch.name,
          initialChildren: children,
        );

  static const String name = 'RouteSearch';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i11.PageVideo]
class RouteVideo extends _i12.PageRouteInfo<void> {
  const RouteVideo({List<_i12.PageRouteInfo>? children})
      : super(
          RouteVideo.name,
          initialChildren: children,
        );

  static const String name = 'RouteVideo';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}
