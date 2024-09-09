import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:fall_24_flutter_course/templates/lab5/app_router/app_router.gr.dart';

class CatGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    String code = (resolver.route.args as CatRouteArgs).statusCode;
    if (await _isStatusCodeInvalid(code)) {
      resolver.redirect(const ErrorRoute());
    } else {
      resolver.next();
    }
  }

  Future<bool> _isStatusCodeInvalid(String statusCode) async {
    try {
      final Dio dio = Dio();
      final Response response = await dio.get('https://http.cat/$statusCode');
      return response.statusCode != 200;
    } catch (e) {
      return true;
    }
  }
}
