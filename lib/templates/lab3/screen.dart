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
        actions: [
          IconButton(
            onPressed: () => ref.read(waterIntakeProvider.notifier).reset(),
            icon: Icon(Icons.refresh, color: Colors.blueAccent, size: 40),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('water intake: ${waterIntake <= 10.0 ? waterIntake : 10} liters', style: TextStyle(fontSize: 20, color: Colors.black),),
            HydrationWidget(waterIntakeLevel: waterIntake),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        onPressed: () => ref.read(waterIntakeProvider.notifier).increment(1),
        child: Icon(Icons.add)
      ),
    );
  }
}
