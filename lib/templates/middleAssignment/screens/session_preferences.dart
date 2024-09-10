import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/session_provider.dart';
import 'session_overview.dart';

class SessionPreferencesScreen extends ConsumerWidget {
  const SessionPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPreferences = ref.watch(userPreferencesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Preferences',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Session Length: ${userPreferences.sessionLength} minutes',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            Slider(
              value: userPreferences.sessionLength.toDouble(),
              min: 1,
              max: 10,
              divisions: 10,
              label: '${userPreferences.sessionLength} minutes',
              onChanged: (value) {
                ref.read(userPreferencesProvider.notifier).setSessionLength(value.toInt());
              },
              activeColor: Colors.black,
              inactiveColor: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              'Hot Phase Duration: ${userPreferences.hotPhaseDuration} seconds',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            Slider(
              value: userPreferences.hotPhaseDuration.toDouble(),
              min: 5,
              max: 30,
              label: '${userPreferences.hotPhaseDuration} seconds',
              onChanged: (value) {
                ref.read(userPreferencesProvider.notifier).setHotPhaseDuration(value.toInt());
              },
              activeColor: Colors.black,
              inactiveColor: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              'Cold Phase Duration: ${userPreferences.coldPhaseDuration} seconds',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            Slider(
              value: userPreferences.coldPhaseDuration.toDouble(),
              min: 5,
              max: 30,
              label: '${userPreferences.coldPhaseDuration} seconds',
              onChanged: (value) {
                ref.read(userPreferencesProvider.notifier).setColdPhaseDuration(value.toInt());
              },
              activeColor: Colors.black,
              inactiveColor: Colors.grey[300],
            ),
            const SizedBox(height: 24),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SessionOverviewScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
