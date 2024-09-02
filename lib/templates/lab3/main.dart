import 'package:fall_24_flutter_course/templates/lab3/hydration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screen.dart';

void main() {
  runApp(
    // TODO to enable riverpod - add ProviderScope
    ProviderScope(
      child: WaterBalanceApp(),
    )
  );
}

class WaterBalanceApp extends StatelessWidget {
  const WaterBalanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WaterBalance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // TODO to run app - change to needed screen widget
      home: HydrationScreen(),
    );
  }
}

