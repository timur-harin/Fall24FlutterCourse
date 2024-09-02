import 'package:fall_24_flutter_course/templates/lab3/screen.dart';
import 'package:fall_24_flutter_course/templates/lab3/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'notifier.dart';

void main() => runApp(
  ProviderScope(
    overrides: [
      localStorageServiceProvider.overrideWithValue(LocalStorageService())
    ],
    child: const WaterBalanceApp(),
  ),
);

class WaterBalanceApp extends StatelessWidget {
  const WaterBalanceApp({super.key});

  @override
  Widget build(BuildContext context) =>
      MaterialApp(
        title: 'WaterBalance',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HydrationScreen(),
      );
}
