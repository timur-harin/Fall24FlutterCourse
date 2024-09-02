import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fall_24_flutter_course/templates/lab3/hydration.dart';
import 'notifier.dart';

class HydrationScreen extends ConsumerWidget {
  const HydrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final waterIntake = ref.watch(waterIntakeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('WaterBalance'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Water Intake: ${waterIntake.toStringAsFixed(2)} L'),
            SizedBox(height: 20),
            HydrationWidget(waterIntakeLevel: waterIntake),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              ref.read(waterIntakeProvider.notifier).increment(0.25);
            },
            child: Icon(Icons.add),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              ref.read(waterIntakeProvider.notifier).reset();
            },
            child: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
