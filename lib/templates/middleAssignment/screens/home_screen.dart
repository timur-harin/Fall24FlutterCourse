import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/session_provider.dart';
import 'session_preferences.dart';
import 'session_summary.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionHistory = ref.watch(sessionHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contrast Shower Companion',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: sessionHistory.isEmpty
                  ? const Center(
                      child: Text(
                        'No sessions yet. Start a new one!',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    )
                  : ListView.builder(
                      itemCount: sessionHistory.length,
                      itemBuilder: (context, index) {
                        final session = sessionHistory[index];
                        return Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: ListTile(
                            title: Row(
                              children: [
                                const Icon(Icons.calendar_today, color: Colors.black54, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  '${session.dateTime.day}/${session.dateTime.month}/${session.dateTime.year} ${session.dateTime.hour}:${session.dateTime.minute}',
                                  style: const TextStyle(fontSize: 16, color: Colors.black),
                                ),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                const Icon(Icons.timer, color: Colors.black54, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  '${session.totalDuration} s',
                                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                                ),
                              ],
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: _buildRatingIcon(session.rating),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SessionSummaryScreen(
                                    session: session,
                                    sessionKey: session.key as int,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SessionPreferencesScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'New Session',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingIcon(int? rating) {
    double iconSize = 30;
    if (rating == null) {
      return Icon(Icons.sentiment_neutral, color: Colors.grey, size: iconSize);
    }
    switch (rating) {
      case 1:
        return Icon(Icons.sentiment_very_dissatisfied, color: Colors.red, size: iconSize);
      case 2:
        return Icon(Icons.sentiment_neutral, color: Colors.yellow, size: iconSize);
      case 3:
        return Icon(Icons.sentiment_very_satisfied, color: Colors.green, size: iconSize);
      default:
        return Icon(Icons.sentiment_neutral, color: Colors.grey, size: iconSize);
    }
  }
}
