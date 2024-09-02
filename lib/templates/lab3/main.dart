import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screen.dart';

void main() {
  runApp(
    ProviderScope(
      child: WaterBalanceApp(),
    ),
  );
}

class WaterBalanceApp extends StatelessWidget {
  const WaterBalanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab3',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HydrationScreen(),
    );
  }
}
