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
        title: const Text('Water Balancer'),
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
              'Water Intake: $waterIntake',
              style: const TextStyle(fontSize: 20, color: Colors.blueGrey),
            ),
            const SizedBox(height: 20,),
            HydrationWidget(waterIntakeLevel: waterIntake),
            const SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(waterIntakeProvider.notifier).increment(0.1);
                  }, 
                  child: const Text('0.1L'),
                ),

                ElevatedButton(
                  onPressed: () {
                    ref.read(waterIntakeProvider.notifier).increment(0.25);
                  },
                  child: const Text('0.25L'),
                ),

                const SizedBox(width: 20,),

                ElevatedButton(
                  onPressed: () {
                    ref.read(waterIntakeProvider.notifier).increment(0.5);
                  }, 
                  child: const Text('0.5L'),
                ),

                ElevatedButton(
                  onPressed: () {
                    ref.read(waterIntakeProvider.notifier).increment(1.0);
                  }, 
                  child: const Text('1L'),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(waterIntakeProvider.notifier).increment(0.5),
        child: const Icon(Icons.add),
      ),
    );
  }
}
