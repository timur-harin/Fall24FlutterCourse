import 'package:fall_24_flutter_course/templates/middleAssignment/home_screen.dart';
import 'package:flutter/material.dart';

class SessionSummaryScreen extends StatelessWidget {
  final int totalDuration;
  final int hotDuration;
  final int coldDuration;
  final int phasesCompleted;

  const SessionSummaryScreen({
    super.key,
    required this.totalDuration,
    required this.hotDuration,
    required this.coldDuration,
    required this.phasesCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Total Duration: $totalDuration minutes'),
            Text('Hot Phase: $hotDuration seconds'),
            Text('Cold Phase: $coldDuration seconds'),
            Text('Phases Completed: $phasesCompleted'),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the home screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}