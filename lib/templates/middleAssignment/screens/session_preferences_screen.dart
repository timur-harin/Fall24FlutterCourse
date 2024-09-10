import 'package:flutter/material.dart';
import 'package:mid_assignment/models/temperature_phase.dart';
import 'package:mid_assignment/models/user_preferences.dart';
import 'package:mid_assignment/screens/session_overview_screen.dart';

class SessionPreferencesScreen extends StatefulWidget {
  @override
  _SessionPreferencesScreenState createState() =>
      _SessionPreferencesScreenState();
}

class _SessionPreferencesScreenState extends State<SessionPreferencesScreen> {
  List<TemperaturePhase> _phases = [];
  int _currentPhaseDuration = 5;
  String _currentPhaseType = 'Hot';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Session Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            DropdownButton<String>(
              value: _currentPhaseType,
              items: <String>['Hot', 'Cold']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _currentPhaseType = newValue!;
                });
              },
            ),
            Text('Phase Duration: $_currentPhaseDuration minutes'),
            Slider(
              value: _currentPhaseDuration.toDouble(),
              min: 1,
              max: 30,
              divisions: 29,
              label: _currentPhaseDuration.toString(),
              onChanged: (double value) {
                setState(() {
                  _currentPhaseDuration = value.round();
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _phases.add(TemperaturePhase(
                      phaseType: _currentPhaseType,
                      duration: _currentPhaseDuration));
                });
              },
              child: Text('Add Phase'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _phases.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${_phases[index].phaseType} Phase'),
                    subtitle:
                        Text('Duration: ${_phases[index].duration} minutes'),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                UserPreferences preferences = UserPreferences(phases: _phases);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SessionOverviewScreen(preferences: preferences),
                  ),
                );
              },
              child: Text('Session Overview'),
            ),
          ],
        ),
      ),
    );
  }
}
