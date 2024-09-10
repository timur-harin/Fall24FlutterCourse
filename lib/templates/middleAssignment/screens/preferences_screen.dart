import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'overview_screen.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/session_provider.dart';

class SessionPreferencesScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPreferences = ref.watch(userPreferencesProvider);
    final userPreferencesNotifier = ref.read(userPreferencesProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('session preferences', style: TextStyle(fontSize: 40, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        toolbarHeight: 100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('hot duration: ${userPreferences.hotDuration.inSeconds} seconds', style: TextStyle(color: const Color.fromARGB(255, 255, 97, 97), fontSize: 20)),
            Slider(
              value: userPreferences.hotDuration.inSeconds.toDouble(),
              min: 10,
              max: 180,
              divisions: 34,
              activeColor: Color.fromARGB(255, 255, 133, 133),
              label: userPreferences.hotDuration.inSeconds.toString(),
              onChanged: (double value) {
                userPreferencesNotifier.updatePreferences(
                  Duration(seconds: value.toInt()),
                  userPreferences.coldDuration,
                  userPreferences.hotTemperature,
                  userPreferences.coldTemperature,
                );
              },
            ),
            SizedBox(height: 20),
            Text('hot temperature: ${userPreferences.hotTemperature.toDouble()} °C', style: TextStyle(color: const Color.fromARGB(255, 255, 97, 97), fontSize: 20)),
            Slider(
              value: userPreferences.hotTemperature,
              min: 30,
              max: 50,
              divisions: 20,
              activeColor: Color.fromARGB(255, 255, 133, 133),
              label: userPreferences.hotTemperature.toString(),
              onChanged: (double value) {
                userPreferencesNotifier.updatePreferences(
                  userPreferences.hotDuration,
                  userPreferences.coldDuration,
                  value,
                  userPreferences.coldTemperature,
                );
              },
            ),
            SizedBox(height: 20),
            Text('cold duration: ${userPreferences.coldDuration.inSeconds} seconds', style: TextStyle(color: Colors.blue, fontSize: 20)),
            Slider(
              value: userPreferences.coldDuration.inSeconds.toDouble(),
              min: 10,
              max: 180,
              divisions: 34,
              activeColor: Colors.blue,
              label: userPreferences.coldDuration.inSeconds.toString(),
              onChanged: (double value) {
                userPreferencesNotifier.updatePreferences(
                  userPreferences.hotDuration,
                  Duration(seconds: value.toInt()),
                  userPreferences.hotTemperature,
                  userPreferences.coldTemperature,
                );
              },
            ),
            SizedBox(height: 20),
            Text('cold temperature: ${userPreferences.coldTemperature.toDouble()} °C', style: TextStyle(color: Colors.blue, fontSize: 20)),
            Slider(
              value: userPreferences.coldTemperature,
              min: 10,
              max: 30,
              divisions: 20,
              activeColor: Colors.blue,
              label: userPreferences.coldTemperature.toString(),
              onChanged: (double value) {
                userPreferencesNotifier.updatePreferences(
                  userPreferences.hotDuration,
                  userPreferences.coldDuration,
                  userPreferences.hotTemperature,
                  value,
                );
              },
            ),
            SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SessionOverviewScreen(),
                    ),
                  );
                },
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.lightBlueAccent)),
                child: Text('next', style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}