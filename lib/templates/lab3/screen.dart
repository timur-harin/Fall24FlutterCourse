import 'package:fall_24_flutter_course/templates/lab3/hydration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'notifier.dart'; 


final waterIntakeProvider = StateNotifierProvider<WaterIntakeNotifier, double>((ref) {
  return WaterIntakeNotifier(ref.watch(localStorageServiceProvider));
});

class HydrationScreen extends ConsumerWidget {
  const HydrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO - Add ref.watch and use provider to get the water intake
    final waterIntake = ref.watch(waterIntakeProvider);
    return Scaffold(
      // TODO add AppBar with Icon to reset the water intake as actions parameter of AppBar
      appBar: AppBar(
        title: Text('Hydration'),
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
            // TODO - Add text to display the water intake
            Text(
              'Water Intake: $waterIntake',
            ),
            // TODO add HydrationWidget to display the water intake and put waterIntake into it
            HydrationWidget(waterIntakeLevel: waterIntake)
            // Add more UI components if necessary
          ],
        ),
      ),
      // TODO - Add floating action button to increment the water intake using ref.read(waterIntakeProvider.notifier).increment(x)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (waterIntake + 100 <= 1000) {
            ref.read(waterIntakeProvider.notifier).increment(100);
          } 
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
