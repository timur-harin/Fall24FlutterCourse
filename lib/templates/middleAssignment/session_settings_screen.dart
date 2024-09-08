import 'package:flutter/material.dart';
import 'active_session_screen.dart';

class SessionSettingsScreen extends StatefulWidget {
  @override
  _SessionSettingsScreenState createState() => _SessionSettingsScreenState();
}

class _SessionSettingsScreenState extends State<SessionSettingsScreen> {
  int _hotDuration = 30;
  int _coldDuration = 30;
  int _phaseCount = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Hot Phase Duration (seconds):'),
            Slider(
              value: _hotDuration.toDouble(),
              min: 10,
              max: 120,
              divisions: 11,
              label: '$_hotDuration sec',
              onChanged: (value) {
                setState(() {
                  _hotDuration = value.toInt();
                });
              },
            ),
            const SizedBox(height: 20),
            const Text('Cold Phase Duration (seconds):'),
            Slider(
              value: _coldDuration.toDouble(),
              min: 10,
              max: 120,
              divisions: 11,
              label: '$_coldDuration sec',
              onChanged: (value) {
                setState(() {
                  _coldDuration = value.toInt();
                });
              },
            ),
            const SizedBox(height: 20),
            const Text('Number of Phases:'),
            Slider(
              value: _phaseCount.toDouble(),
              min: 2,
              max: 10,
              divisions: 4,
              label: '$_phaseCount phases',
              onChanged: (value) {
                setState(() {
                  _phaseCount = value.toInt();
                });
              },
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActiveSessionScreen(
                      hotPhaseDuration: _hotDuration,
                      coldPhaseDuration: _coldDuration,
                      totalPhases: _phaseCount,
                    ),
                  ),
                );
              },
              child: const Text('Start Session'),
            ),
          ],
        ),
      ),
    );
  }
}
