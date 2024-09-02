import 'package:fall_24_flutter_course/templates/lab3/hydration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'notifier.dart';

class HydrationScreen extends ConsumerWidget {
  const HydrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final waterIntake = ref.watch(waterIntakeProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => ref.read(waterIntakeProvider.notifier).reset(),
            icon: const Icon(Icons.water_drop),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(waterIntake.toStringAsFixed(1)),
            HydrationWidget(waterIntakeLevel: waterIntake),
            const SizedBox(height: 80.0),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => ref.read(waterIntakeProvider.notifier).increment(0.1),
      ),
    );
  }
}
