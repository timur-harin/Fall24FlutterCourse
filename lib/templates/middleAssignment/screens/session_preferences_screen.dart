import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/active_session_provider.dart';
import '../providers/session_preferences_provider.dart';
import '../models/session_preferences.dart';

class SessionPreferencesScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(sessionPreferencesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Session Preferences'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildDurationSlider(context, ref, preferences),
          _buildTemperatureIntervalSlider(context, ref, preferences),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text('Begin Session'),
            onPressed: () {
              ref.read(activeSessionProvider.notifier).startSession( context);
              Navigator.pushNamed(context, '/active_session');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDurationSlider(BuildContext context, WidgetRef ref, SessionPreferences preferences) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Session Duration (minutes):'),
        Slider(
          value: preferences.duration.toDouble(),
          min: 1,
          max: 30,
          divisions: 29,
          label: preferences.duration.toString(),
          onChanged: (value) {
            ref.read(sessionPreferencesProvider.notifier).setDuration(value.toInt());
          },
        ),
      ],
    );
  }

  Widget _buildTemperatureIntervalSlider(BuildContext context, WidgetRef ref, SessionPreferences preferences) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Temperature Interval (seconds):'),
        Slider(
          value: preferences.temperatureInterval.toDouble(),
          min: 10,
          max: 120,
          divisions: 11,
          label: preferences.temperatureInterval.toString(),
          onChanged: (value) {
            ref.read(sessionPreferencesProvider.notifier).setTemperatureInterval(value.toInt());
          },
        ),
      ],
    );
  }
}
