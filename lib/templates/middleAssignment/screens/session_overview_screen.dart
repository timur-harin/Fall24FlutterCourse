import 'package:flutter/material.dart';
import 'package:mid_assignment/models/user_preferences.dart';
import 'package:mid_assignment/screens/active_session_screen.dart';

class SessionOverviewScreen extends StatelessWidget {
  final UserPreferences preferences;

  SessionOverviewScreen({required this.preferences});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Session Overview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: preferences.phases.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${preferences.phases[index].phaseType} Phase'),
                    subtitle: Text(
                        'Duration: ${preferences.phases[index].duration} minutes'),
                  );
                },
              ),
            ),
            Text(
                'Total Duration: ${preferences.phases.fold(0, (prev, element) => prev + element.duration)} minutes'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ActiveSessionScreen(preferences: preferences),
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
