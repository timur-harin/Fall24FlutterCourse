import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/session_preferences_provider.dart';
import '../providers/active_session_provider.dart';

class SessionOverviewScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(sessionPreferencesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Session Overview'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Duration: ${preferences.duration} minutes',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            'Temperature Interval: ${preferences.temperatureInterval} seconds',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text('Begin Session'),
            onPressed: () {
              ref.read(activeSessionProvider.notifier).startSession( context);
              Navigator.pushReplacementNamed(context, '/active_session');
            },
          ),
        ],
      ),
    );
  }
}
