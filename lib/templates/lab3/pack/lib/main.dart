library pack;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      title: 'WaterBalance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Set the home screen widget
      home: HydrationHome(), // Replace with your actual home widget
    );
  }
}

class HydrationHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Balance'),
      ),
      body: Center(
        child: Text('Welcome to Water Balance!'),
      ),
    );
  }
}
