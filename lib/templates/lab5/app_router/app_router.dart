import 'package:auto_route/auto_route.dart';
import 'package:fall_24_flutter_course/templates/lab5/app_router/app_router.gr.dart';

import 'cat_guard.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          initial: true,
          page: HomeRoute.page,
        ),
        AutoRoute(
          page: CatRoute.page,
          guards: [CatGuard()],
        ),
        AutoRoute(page: ErrorRoute.page),
      ];
}
