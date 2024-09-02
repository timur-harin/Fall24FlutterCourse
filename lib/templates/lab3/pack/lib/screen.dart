import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'hydration.dart';
import 'notifier.dart';

class HydrationScreen extends ConsumerWidget {
  const HydrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final waterIntake = ref.watch(waterIntakeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hydration Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              ref.read(waterIntakeProvider.notifier).reset();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Current Water Intake:',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              '${waterIntake.toStringAsFixed(2)} liters',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            HydrationWidget(waterIntakeLevel: waterIntake),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(waterIntakeProvider.notifier).increment(0.5);
        },
        child: const Icon(Icons.add),
        tooltip: 'Add Water Intake',
      ),    );
  }
}
