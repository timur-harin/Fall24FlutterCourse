import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fall_24_flutter_course/templates/lab3/notifier.dart';
import 'package:fall_24_flutter_course/templates/lab3/hydration.dart';

class HydrationScreen extends ConsumerWidget {
  const HydrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO - Add ref.watch and use provider to get the water intake
    final waterIntake = ref.watch(waterIntakeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 3'),
        actions: [
          IconButton(
            onPressed: () => {ref.read(waterIntakeProvider.notifier).reset()},
            icon: const Icon(Icons.restart_alt),
            iconSize: 32
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Your water intake today: ${waterIntake.toStringAsFixed(1)}",
              style: TextStyle(fontSize: 24),
            ),
            HydrationWidget(waterIntakeLevel: waterIntake)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {ref.read(waterIntakeProvider.notifier).increment(0.1)},
        child: const Icon(Icons.add)
      ),
    );
  }
}
