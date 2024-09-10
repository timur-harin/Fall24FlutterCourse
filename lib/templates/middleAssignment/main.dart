import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'appTheme/theme_notifier.dart';
import 'app_router/app_router.dart';
import 'presentation/screens/home/home_screen.dart';

void main() {
  runApp(MiddleAssigmentApp());
}

class MiddleAssigmentApp extends StatelessWidget {
  MiddleAssigmentApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer(builder: (context, ref, child) {
        final theme = ref.watch(themeNotifierProvider);

        return MaterialApp.router(
          routerConfig: _appRouter.config(),
          title: 'Middle Assigment',
          theme: theme,
        );
      }),
    );
  }
}
