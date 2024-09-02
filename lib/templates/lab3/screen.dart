import 'package:fall_24_flutter_course/templates/lab3/hydration.dart';
import 'package:fall_24_flutter_course/templates/lab3/notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HydrationScreen extends ConsumerWidget {
  const HydrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final waterIntake = ref.watch(waterIntakeProvider);
    final waterIntakeNotifier = ref.watch(waterIntakeProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: waterIntakeNotifier.reset,
              icon: const Icon(Icons.cancel),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Water intake: $waterIntake"),
            HydrationWidget(waterIntakeLevel: waterIntake)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => waterIntakeNotifier.increment(0.1)),
    );
  }
}
