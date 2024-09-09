// Use these dependencies for your classes
import 'package:fall_24_flutter_course/templates/lab5/app_router/app_router.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(Lab5());
}

class Lab5 extends StatelessWidget {
  Lab5({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
    );
  }
}

// TODO add needed classes for Flutter APP

// TODO add generated route flutter app with undifined page with cat status code using api

// TODO add putting argument in route navigation as parameter for generated page

// TODO use api with cat status codes
// https://http.cat/[status_code]

