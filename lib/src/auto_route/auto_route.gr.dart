// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:guia_click/pages/auth/login/page_login.dart' as _i3;
import 'package:guia_click/pages/auth/register/page_register.dart' as _i6;
import 'package:guia_click/pages/favorites/page_favorites.dart' as _i1;
import 'package:guia_click/pages/home/page_home.dart' as _i2;
import 'package:guia_click/pages/manual/page_manual.dart' as _i4;

/// generated route for
/// [_i1.PageFavorites]
class RouteFavorites extends _i7.PageRouteInfo<void> {
  const RouteFavorites({List<_i7.PageRouteInfo>? children})
      : super(RouteFavorites.name, initialChildren: children);

  static const String name = 'RouteFavorites';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i1.PageFavorites();
    },
  );
}

/// generated route for
/// [_i2.PageHome]
class RouteHome extends _i7.PageRouteInfo<void> {
  const RouteHome({List<_i7.PageRouteInfo>? children})
      : super(RouteHome.name, initialChildren: children);

  static const String name = 'RouteHome';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.PageHome();
    },
  );
}

/// generated route for
/// [_i3.PageLogin]
class RouteLogin extends _i7.PageRouteInfo<void> {
  const RouteLogin({List<_i7.PageRouteInfo>? children})
      : super(RouteLogin.name, initialChildren: children);

  static const String name = 'RouteLogin';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.PageLogin();
    },
  );
}

/// generated route for
/// [_i4.PageManual]
class RouteManual extends _i7.PageRouteInfo<RouteManualArgs> {
  RouteManual({
    _i8.Key? key,
    required int manualId,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          RouteManual.name,
          args: RouteManualArgs(key: key, manualId: manualId),
          initialChildren: children,
        );

  static const String name = 'RouteManual';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RouteManualArgs>();
      return _i4.PageManual(key: args.key, manualId: args.manualId);
    },
  );
}

class RouteManualArgs {
  const RouteManualArgs({this.key, required this.manualId});

  final _i8.Key? key;

  final int manualId;

  @override
  String toString() {
    return 'RouteManualArgs{key: $key, manualId: $manualId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RouteManualArgs) return false;
    return key == other.key && manualId == other.manualId;
  }

  @override
  int get hashCode => key.hashCode ^ manualId.hashCode;
}

/// generated route for
/// [_i6.PageRegister]
class RouteRegister extends _i7.PageRouteInfo<void> {
  const RouteRegister({List<_i7.PageRouteInfo>? children})
      : super(RouteRegister.name, initialChildren: children);

  static const String name = 'RouteRegister';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.PageRegister();
    },
  );
}
