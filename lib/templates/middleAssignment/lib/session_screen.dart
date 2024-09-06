import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shower_session.dart';
import 'session_active_screen.dart';
import 'user_preferences.dart';
import 'session_provider.dart';

class SessionScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPrefs = ref.watch(preferencesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('New Shower Session'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Customize your shower session'),
            Text('Hot phase duration: ${userPrefs.hotPhase} seconds'),
            Text('Cold phase duration: ${userPrefs.coldPhase} seconds'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Create a new session with preferences
                List<TemperaturePhase> phases = [];
                for (int i = 0; i < userPrefs.totalPhases; i++) {
                  phases.add(TemperaturePhase(
                      isHot: true, duration: userPrefs.hotPhase));
                  phases.add(TemperaturePhase(
                      isHot: false, duration: userPrefs.coldPhase));
                }

                final session = ShowerSession(
                  startTimer: DateTime.now(),
                  totalDuration: (userPrefs.hotPhase +
                          userPrefs.coldPhase) *
                      userPrefs.totalPhases,
                  phases: phases,
                );

                // Navigate to active session screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SessionActiveScreen(session: session),
                  ),
                );
              },
              child: Text('Begin Session'),
            ),
          ],
        ),
      ),
    );
  }
}
