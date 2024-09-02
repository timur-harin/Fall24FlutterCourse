import 'package:fall_24_flutter_course/templates/lab3/hydration.dart';
import 'package:fall_24_flutter_course/templates/lab3/notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HydrationScreen extends ConsumerWidget {
  const HydrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO - Add ref.watch and use provider to get the water intake
    final waterIntake = ref.watch(waterIntakeProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
        IconButton(onPressed: (){
          ref.read(waterIntakeProvider.notifier).reset();
        }, icon: Icon(Icons.reset_tv))
        ],
      ),
      // TODO add AppBar with Icon to reset the water intake as actions parameter of AppBar
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("${waterIntake}"),
            HydrationWidget(waterIntakeLevel: waterIntake)
            // TODO - Add text to display the water intake
            // TODO add HydrationWidget to display the water intake and put waterIntake into it
            // Add more UI components if necessary
          ],
        ),
      ),
      floatingActionButton: IconButton(onPressed:(){ref.read(waterIntakeProvider.notifier).increment(1); }, icon: Icon(Icons.water, color: Colors.black,)),
      // TODO - Add floating action button to increment the water intake using ref.read(waterIntakeProvider.notifier).increment(x)
    );
  }
}