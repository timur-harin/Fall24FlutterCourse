import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'hydration.dart';
import 'notifier.dart';

class HydrationScreen extends ConsumerWidget {
  const HydrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Add ref.watch and use provider to get the water intake
    final waterIntake = ref.watch(waterIntakeProvider);
    return Scaffold(
      // AppBar with Icon to reset the water intake as actions parameter of AppBar
      appBar: AppBar(
        title: const Text('WaterBalance'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Reset the water intake using Riverpod notifier
              ref.read(waterIntakeProvider.notifier).reset();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Display the current water intake level
            Text(
              'Water Intake: ${waterIntake.toStringAsFixed(2)} liters',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            // Display the HydrationWidget with the current water intake level
            HydrationWidget(waterIntakeLevel: waterIntake),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Increment the water intake by 0.25 liters using Riverpod notifier
          ref.read(waterIntakeProvider.notifier).increment(0.25);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
