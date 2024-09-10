import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'session_provider.dart';

class SessionHistory extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionHistory = ref.watch(historyProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Session History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: sessionHistory.isEmpty
            ? Center(
                child: Text(
                  "No sessions yet.",
                  style: TextStyle(fontSize: 18),
                ),
              )
            : ListView.builder(
                itemCount: sessionHistory.length,
                itemBuilder: (context, index) {
                  final session = sessionHistory[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text('Session on ${session.startTime}'),
                      subtitle: Text(
                          'Duration: ${session.duration} seconds, Phases: ${session.phases.length}'),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
