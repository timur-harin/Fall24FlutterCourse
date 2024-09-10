import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/current_session_provider.dart';
import '../providers/session_history_provider.dart';
import '../utils/time_utils.dart';

class SessionSummaryScreen extends ConsumerStatefulWidget {
  const SessionSummaryScreen({super.key});

  @override
  _SessionSummaryScreenState createState() => _SessionSummaryScreenState();
}

class _SessionSummaryScreenState extends ConsumerState<SessionSummaryScreen> {
  int _rating = 5;

  @override
  Widget build(BuildContext context) {
    final currentSession = ref.watch(currentSessionProvider);
    final totalActiveTime = ref.watch(currentSessionProvider.notifier).getTotalActiveTime();

    if (currentSession == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Session Summary'),
          backgroundColor: Colors.blueAccent,
        ),
        body: const Center(
          child: Text('No session data available.'),
        ),
      );
    }

    final phases = currentSession.phases;
    final sessionStartTime = currentSession.dateTime;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Summary'),
        backgroundColor: Colors.blueAccent,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Session Complete!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            const SizedBox(height: 16),
            Text(
              formatTotalTime(totalActiveTime),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Text(
              'Number of Phases: ${phases.length}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            const Text(
              'Phase Details:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: phases.length,
                itemBuilder: (context, index) {
                  final phase = phases[index];
                  final phaseDuration = phase.duration.inSeconds;

                  final phaseStartTime = sessionStartTime.add(
                    Duration(seconds: phases.take(index).fold(
                      0,
                      (sum, p) => sum + p.duration.inSeconds,
                    )),
                  );
                  final phaseEndTime = phaseStartTime.add(phase.duration);

                  final isCompleted = totalActiveTime >= phaseEndTime.difference(sessionStartTime);

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        'Phase ${index + 1}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        'Duration: $phaseDuration seconds\nTemperature: ${phase.isHot ? 'Hot' : 'Cold'}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      trailing: Text(
                        isCompleted ? 'Passed' : 'Not Completed',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isCompleted ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Rate your session:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.yellow[700],
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1;
                    });
                    ref.read(currentSessionProvider.notifier).rateSession(_rating);
                  },
                );
              }),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await addShowerSession(currentSession, ref);
                ref.invalidate(sessionHistoryProvider);
                ref.read(currentSessionProvider.notifier).clearSession();
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Save and Return to Home',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
