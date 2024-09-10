// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:fall_24_flutter_course/templates/middleAssignment/domain/session_entity.dart'
    as _i7;
import 'package:fall_24_flutter_course/templates/middleAssignment/presentation/screens/details/session_details_screen.dart'
    as _i2;
import 'package:fall_24_flutter_course/templates/middleAssignment/presentation/screens/home/home_screen.dart'
    as _i1;
import 'package:fall_24_flutter_course/templates/middleAssignment/presentation/screens/overview/session_overview.dart'
    as _i3;
import 'package:fall_24_flutter_course/templates/middleAssignment/presentation/screens/preferences/session_preferences_screen.dart'
    as _i4;
import 'package:fall_24_flutter_course/templates/middleAssignment/presentation/screens/preferences/session_preferences_state.dart'
    as _i8;
import 'package:neumorphic_ui/neumorphic_ui.dart' as _i6;

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomeScreen();
    },
  );
}

/// generated route for
/// [_i2.SessionDetailsScreen]
class SessionDetailsRoute extends _i5.PageRouteInfo<SessionDetailsRouteArgs> {
  SessionDetailsRoute({
    _i6.Key? key,
    required _i7.SessionEntity session,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          SessionDetailsRoute.name,
          args: SessionDetailsRouteArgs(
            key: key,
            session: session,
          ),
          initialChildren: children,
        );

  static const String name = 'SessionDetailsRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SessionDetailsRouteArgs>();
      return _i2.SessionDetailsScreen(
        key: args.key,
        session: args.session,
      );
    },
  );
}

class SessionDetailsRouteArgs {
  const SessionDetailsRouteArgs({
    this.key,
    required this.session,
  });

  final _i6.Key? key;

  final _i7.SessionEntity session;

  @override
  String toString() {
    return 'SessionDetailsRouteArgs{key: $key, session: $session}';
  }
}

/// generated route for
/// [_i3.SessionOverviewScreen]
class SessionOverviewRoute extends _i5.PageRouteInfo<SessionOverviewRouteArgs> {
  SessionOverviewRoute({
    _i6.Key? key,
    required _i8.CreateSessionState createdSession,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          SessionOverviewRoute.name,
          args: SessionOverviewRouteArgs(
            key: key,
            createdSession: createdSession,
          ),
          initialChildren: children,
        );

  static const String name = 'SessionOverviewRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SessionOverviewRouteArgs>();
      return _i3.SessionOverviewScreen(
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

  final _i6.Key? key;

  final _i8.CreateSessionState createdSession;

  @override
  String toString() {
    return 'SessionOverviewRouteArgs{key: $key, createdSession: $createdSession}';
  }
}

/// generated route for
/// [_i4.SessionPreferencesScreen]
class SessionPreferencesRoute extends _i5.PageRouteInfo<void> {
  const SessionPreferencesRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SessionPreferencesRoute.name,
          initialChildren: children,
        );

  static const String name = 'SessionPreferencesRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.SessionPreferencesScreen();
    },
  );
}
