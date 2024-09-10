// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:fall_24_flutter_course/templates/middleAssignment/presentation/home/screens/home_screen.dart'
    as _i1;
import 'package:fall_24_flutter_course/templates/middleAssignment/presentation/home/screens/session_overview.dart'
    as _i2;
import 'package:fall_24_flutter_course/templates/middleAssignment/presentation/home/screens/session_preferences_screen.dart'
    as _i3;
import 'package:fall_24_flutter_course/templates/middleAssignment/presentation/home/screens/session_preferences_state.dart'
    as _i6;
import 'package:flutter/material.dart' as _i5;

/// generated route for
/// [_i1.HomeScreen]
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
      return const _i1.HomeScreen();
    },
  );
}

/// generated route for
/// [_i2.SessionOverviewScreen]
class SessionOverviewRoute extends _i4.PageRouteInfo<SessionOverviewRouteArgs> {
  SessionOverviewRoute({
    _i5.Key? key,
    required _i6.CreateSessionState createdSession,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          SessionOverviewRoute.name,
          args: SessionOverviewRouteArgs(
            key: key,
            createdSession: createdSession,
          ),
          initialChildren: children,
        );

  static const String name = 'SessionOverviewRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SessionOverviewRouteArgs>();
      return _i2.SessionOverviewScreen(
        key: args.key,
        createdSession: args.createdSession,
      );
    },
  );
}

class SessionOverviewRouteArgs {
  const SessionOverviewRouteArgs({
    this.key,
    required this.createdSession,
  });

  final _i5.Key? key;

  final _i6.CreateSessionState createdSession;

  @override
  String toString() {
    return 'SessionOverviewRouteArgs{key: $key, createdSession: $createdSession}';
  }
}

/// generated route for
/// [_i3.SessionPreferencesScreen]
class SessionPreferencesRoute extends _i4.PageRouteInfo<void> {
  const SessionPreferencesRoute({List<_i4.PageRouteInfo>? children})
      : super(
          SessionPreferencesRoute.name,
          initialChildren: children,
        );

  static const String name = 'SessionPreferencesRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.SessionPreferencesScreen();
    },
  );
}
