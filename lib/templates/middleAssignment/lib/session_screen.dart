import 'package:flutter/material.dart';
import 'dart:async'; // For the timer
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'session_active_screen.dart';
import 'shower_session.dart';
import 'session_provider.dart'; // Your session and preferences provider

class SessionScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int _counter = 5; // Starting timer at 5 seconds
    Timer? _timer;

    // Function to navigate to the active session screen
    void _navigateToActiveSession(BuildContext context, WidgetRef ref) {
      final userPreferences = ref.read(preferencesProvider);

      ShowerSession session = ShowerSession(phases: List.generate(
        userPreferences.totalPhases * 2, // Hot and Cold alternating
            (index) => TemperaturePhase(
          isHot: index % 2 == 0, // Even index = Hot, Odd index = Cold
          duration: index % 2 == 0 ? userPreferences.hotPhase : userPreferences.coldPhase,
        ),
      ));

      ref.read(sessionProvider.notifier).startSession(session);

      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => SessionActiveScreen(session: session),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: Duration(seconds: 1), // Fade transition duration
        ),
      );
    }

    // Function to start the countdown timer
    void _startTimer() {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer?.cancel();
          _navigateToActiveSession(context, ref);
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Contrast Shower Companion'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'New session will start soon',
              style: TextStyle(
                fontSize: 24, // 24pt font size for the main message
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30), // Spacing between message and the circle
            ElevatedButton(
              onPressed: () {
                _startTimer();
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(), backgroundColor: Colors.blue,
                padding: EdgeInsets.all(50), // Background color of the button
              ),
              child: Text(
                '$_counter', // Display the countdown timer inside the circle
                style: TextStyle(
                  fontSize: 48, // Larger font size for the timer
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // White text for better contrast
                ),
              ),
            ),
            SizedBox(height: 20), // Additional space below timer
          ],
        ),
      ),
    );
  }
}
