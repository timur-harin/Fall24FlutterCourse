import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'session_settings_screen.dart';
import 'session_history_provider.dart';

class SessionHistoryScreen extends ConsumerWidget {
  const SessionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionHistory = ref.watch(sessionHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Session History'),
      ),
      body: ListView.builder(
        itemCount: sessionHistory.length,
        itemBuilder: (context, index) {
          var session = sessionHistory[index];
          return ListTile(
            title: Text('Session ${index + 1}'),
            subtitle: Text('Phases: ${session['totalPhases']}, Hot: ${session['hotDuration']}s, Cold: ${session['coldDuration']}s'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SessionSettingsScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
