import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'notifier.dart';
import 'painter.dart';

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
            icon: const Icon(Icons.refresh),
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
              'Water Intake: ${waterIntake.toStringAsFixed(1)} L',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            WaterPainterWidget(waterIntakeLevel: waterIntake),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (waterIntake < 5.0) {
            ref.read(waterIntakeProvider.notifier).increment(0.25);
          } else {
            // Show a SnackBar when maximum limit is reached
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('You have reached the maximum water intake limit of 5 liters!'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        tooltip: 'Add Water',
        child: const Icon(Icons.local_drink),
      ),
    );
  }
}
