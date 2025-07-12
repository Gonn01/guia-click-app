// dart format width=80
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
import 'package:guia_click/pages/login/page_login.dart' as _i5;
import 'package:guia_click/pages/manual/page_manual.dart' as _i6;
import 'package:guia_click/pages/my_company/page_my_company.dart' as _i7;
import 'package:guia_click/pages/register/page_register.dart' as _i9;
import 'package:guia_click/pages/search/page_search.dart' as _i10;
import 'package:guia_click/pages/video/page_video.dart' as _i11;
import 'package:guia_click/src/auto_route/nothing_page.dart' as _i8;

/// generated route for
/// [_i1.PageCompanyConfiguration]
class RouteCompanyConfiguration extends _i12.PageRouteInfo<void> {
  const RouteCompanyConfiguration({List<_i12.PageRouteInfo>? children})
    : super(RouteCompanyConfiguration.name, initialChildren: children);

  static const String name = 'RouteCompanyConfiguration';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i1.PageCompanyConfiguration();
    },
  );
}

/// generated route for
/// [_i2.PageCreateManual]
class RouteCreateManual extends _i12.PageRouteInfo<void> {
  const RouteCreateManual({List<_i12.PageRouteInfo>? children})
    : super(RouteCreateManual.name, initialChildren: children);

  static const String name = 'RouteCreateManual';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i2.PageCreateManual();
    },
  );
}

/// generated route for
/// [_i3.PageFavorites]
class RouteFavorites extends _i12.PageRouteInfo<void> {
  const RouteFavorites({List<_i12.PageRouteInfo>? children})
    : super(RouteFavorites.name, initialChildren: children);

  static const String name = 'RouteFavorites';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i3.PageFavorites();
    },
  );
}

/// generated route for
/// [_i4.PageHome]
class RouteHome extends _i12.PageRouteInfo<void> {
  const RouteHome({List<_i12.PageRouteInfo>? children})
    : super(RouteHome.name, initialChildren: children);

  static const String name = 'RouteHome';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i4.PageHome();
    },
  );
}

/// generated route for
/// [_i5.PageLogin]
class RouteLogin extends _i12.PageRouteInfo<void> {
  const RouteLogin({List<_i12.PageRouteInfo>? children})
    : super(RouteLogin.name, initialChildren: children);

  static const String name = 'RouteLogin';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i5.PageLogin();
    },
  );
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
         args: RouteManualArgs(key: key, manualId: manualId),
         initialChildren: children,
       );

  static const String name = 'RouteManual';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RouteManualArgs>();
      return _i6.PageManual(key: args.key, manualId: args.manualId);
    },
  );
}

class RouteManualArgs {
  const RouteManualArgs({this.key, required this.manualId});

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
    : super(RouteMyCompany.name, initialChildren: children);

  static const String name = 'RouteMyCompany';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i7.PageMyCompany();
    },
  );
}

/// generated route for
/// [_i8.PageNothing]
class RouteNothing extends _i12.PageRouteInfo<void> {
  const RouteNothing({List<_i12.PageRouteInfo>? children})
    : super(RouteNothing.name, initialChildren: children);

  static const String name = 'RouteNothing';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i8.PageNothing();
    },
  );
}

/// generated route for
/// [_i9.PageRegister]
class RouteRegister extends _i12.PageRouteInfo<void> {
  const RouteRegister({List<_i12.PageRouteInfo>? children})
    : super(RouteRegister.name, initialChildren: children);

  static const String name = 'RouteRegister';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i9.PageRegister();
    },
  );
}

/// generated route for
/// [_i10.PageSearch]
class RouteSearch extends _i12.PageRouteInfo<void> {
  const RouteSearch({List<_i12.PageRouteInfo>? children})
    : super(RouteSearch.name, initialChildren: children);

  static const String name = 'RouteSearch';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i10.PageSearch();
    },
  );
}

/// generated route for
/// [_i11.PageVideo]
class RouteVideo extends _i12.PageRouteInfo<void> {
  const RouteVideo({List<_i12.PageRouteInfo>? children})
    : super(RouteVideo.name, initialChildren: children);

  static const String name = 'RouteVideo';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i11.PageVideo();
    },
  );
}
