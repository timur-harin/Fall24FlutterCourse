// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:fall_24_flutter_course/templates/lab5/cat_page.dart' as _i1;
import 'package:fall_24_flutter_course/templates/lab5/error_page.dart' as _i2;
import 'package:fall_24_flutter_course/templates/lab5/home_page.dart' as _i3;
import 'package:flutter/material.dart' as _i5;

/// generated route for
/// [_i1.CatPage]
class CatRoute extends _i4.PageRouteInfo<CatRouteArgs> {
  CatRoute({
    _i5.Key? key,
    required String statusCode,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          CatRoute.name,
          args: CatRouteArgs(
            key: key,
            statusCode: statusCode,
          ),
          initialChildren: children,
        );

  static const String name = 'CatRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CatRouteArgs>();
      return _i1.CatPage(
        key: args.key,
        statusCode: args.statusCode,
      );
    },
  );
}

class CatRouteArgs {
  const CatRouteArgs({
    this.key,
    required this.statusCode,
  });

  final _i5.Key? key;

  final String statusCode;

  @override
  String toString() {
    return 'CatRouteArgs{key: $key, statusCode: $statusCode}';
  }
}

/// generated route for
/// [_i2.ErrorPage]
class ErrorRoute extends _i4.PageRouteInfo<void> {
  const ErrorRoute({List<_i4.PageRouteInfo>? children})
      : super(
          ErrorRoute.name,
          initialChildren: children,
        );

  static const String name = 'ErrorRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.ErrorPage();
    },
  );
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomePage();
    },
  );
}
