import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/shower_session.dart';
import '../providers/session_history_provider.dart';
import '../utils/time_utils.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionHistory = ref.watch(sessionHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Full Session History',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: sessionHistory.when(
                data: (sessions) {
                  if (sessions.isEmpty) {
                    return const Center(
                      child: Text(
                        'No sessions available',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }

                  final sortedSessions = List.from(sessions);

                  sortedSessions
                      .sort((a, b) => b.dateTime.compareTo(a.dateTime));

                  return ListView.builder(
                    itemCount: sessions.length,
                    itemBuilder: (context, index) {
                      final session = sortedSessions[index];
                      final formattedDate = DateFormat('dd.MM.yyyy HH:mm:ss')
                          .format(session.dateTime);
                      final formattedTime = formatTotalTime(session.totalTime);
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          title: Text(
                            'Session on $formattedDate',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                formattedTime,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    index < session.rating
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Colors.yellow[700],
                                    size: 20,
                                  );
                                }),
                              ),
                            ],
                          ),
                          leading: const Icon(
                            Icons.history,
                            color: Colors.lightBlueAccent,
                            size: 30,
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              showSessionDetails(context, session);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: Colors.lightBlueAccent,
                            ),
                            child: const Text('More Details'),
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stack) => Center(
                  child: Text(
                    'Error: $error',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.blueAccent,
              ),
              child: const Text(
                'Back to Home',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showSessionDetails(BuildContext context, ShowerSession session) {
  final formattedDate =
      DateFormat('dd.MM.yyyy HH:mm:ss').format(session.dateTime);
  final formattedTime = formatTotalTime(session.totalTime);

  final phaseDetails = session.phases.map((phase) {
    final phaseType = phase.isHot ? 'Hot' : 'Cold';
    final phaseDuration = formatTotalTime(phase.duration);
    return '$phaseType Phase: $phaseDuration';
  }).join('\n');

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Session on $formattedDate'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(formattedTime),
            const SizedBox(height: 10),
            Text('Phases:\n$phaseDetails'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}
