import 'package:fall_24_flutter_course/templates/lab3/hydration.dart';
import 'package:fall_24_flutter_course/templates/lab3/notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HydrationScreen extends ConsumerWidget {
  const HydrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final waterIntake = ref.watch(waterIntakeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water level'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(waterIntakeProvider.notifier).reset();
            }, 
            icon: const Icon(Icons.refresh)
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Intake: $waterIntake',
              style: const TextStyle(fontSize: 24, color: Colors.deepPurple),
            ),
            HydrationWidget(
              waterIntakeLevel: waterIntake,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {ref.read(waterIntakeProvider.notifier).increment(0.1)},
        child: const Icon(
          Icons.add,
        )
      ),
    );
  }
}
