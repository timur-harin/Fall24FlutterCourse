import 'package:fall_24_flutter_course/templates/middleAssignment/notifier.dart';
import 'package:flutter/material.dart';
import 'session_preferences_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  List<List<int>> _loadSessionHistory(List<String> history) {
    final _sessionHistory = history.map((historyItem) {
      List<String> data = historyItem.split(',');
      return data.map((item) => int.parse(item)).toList();
    }).toList();

    return _sessionHistory;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(historyProvider);
    final sessionHistory = _loadSessionHistory(history);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contrast Shower Companion'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (sessionHistory.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: sessionHistory.length,
                  itemBuilder: (context, index) {
                    List<int> sessionData = sessionHistory.reversed.toList()[index];
                    return ListTile(
                      title: Text(
                          'Session: ${sessionData[0]} minutes'),
                      subtitle: Text(
                          '${sessionData[3]} phases, Hot: ${sessionData[1]}s, Cold: ${sessionData[2]}s'),
                    );
                  },
                ),
              )
            else
              const Text('No session history yet'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SessionPreferencesScreen(),
                  ),
                );
              },
              child: const Text('Start New Session'),
            ),
          ],
        ),
      ),
    );
  }
}
