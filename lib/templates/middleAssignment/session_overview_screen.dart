import 'package:fall_24_flutter_course/templates/middleAssignment/session_screen.dart';
import 'package:flutter/material.dart';

class SessionOverviewScreen extends StatelessWidget {
  final int totalDuration;
  final int hotDuration;
  final int coldDuration;

  const SessionOverviewScreen({
    super.key,
    required this.totalDuration,
    required this.hotDuration,
    required this.coldDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Overview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Total Duration: $totalDuration minutes'),
            Text('Hot Phase: $hotDuration seconds'),
            Text('Cold Phase: $coldDuration seconds'),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // TODO: Navigate to the active session screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SessionScreen(
                      totalDuration: totalDuration,
                      hotDuration: hotDuration,
                      coldDuration: coldDuration,
                    ),
                  ),
                );
              },
              child: const Text('Begin Session'),
            ),
          ],
        ),
      ),
    );
  }
}