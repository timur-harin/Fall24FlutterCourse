import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionPreferencesScreen extends ConsumerStatefulWidget {
  const SessionPreferencesScreen({super.key});

  @override
  _SessionPreferencesScreenState createState() => _SessionPreferencesScreenState();
}

class _SessionPreferencesScreenState extends ConsumerState<SessionPreferencesScreen> {
  double _sessionDuration = 10;
  double _temperature = 25;
  double _sessionsAmount = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose your contrast shower preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Slider(
              value: _sessionDuration,
              min: 3,
              max: 60,
              inactiveColor: Colors.blue.shade100,
              label: '${_sessionDuration.round()} seconds',
              onChanged: (double value) {
                setState(() {
                  _sessionDuration = value;
                });
              },
            ),
            Text(
              'Session Duration: ${_sessionDuration.round()} seconds',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 20),
            Slider(
              value: _temperature,
              min: 0,
              max: 50,
              inactiveColor: Colors.blue.shade100,
              label: '${_temperature.round()} °C',
              onChanged: (double value) {
                setState(() {
                  _temperature = value;
                });
              },
            ),
            Text(
              'Temperature: ${_temperature.round()} °C',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 20),
            Slider(
              value: _sessionsAmount,
              min: 1,
              max: 10,
              inactiveColor: Colors.blue.shade100,
              label: '${_sessionsAmount.round()} sessions',
              onChanged: (double value) {
                setState(() {
                  _sessionsAmount = value;
                });
              },
            ),
            Text(
              'Sessions amount: ${_sessionsAmount.round()} sessions',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/session_overview',
            arguments: {
              'sessionDuration': _sessionDuration.round(),
              'temperature': _temperature.round(),
              'sessionsAmount': _sessionsAmount.round(),
            },
          );
        },
        backgroundColor: Colors.blue,
        tooltip: 'Next',
        label: Text(
          'Next',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}
