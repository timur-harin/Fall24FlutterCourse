import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'provider.dart';
import 'session_preferences.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(sessionProvider);
    final recentSessions = sessions.take(5).toList();

    void _addSession(Map<String, dynamic> session) {
      ref.read(sessionProvider.notifier).addSession(Session(
        duration: session['duration'],
        temperatureInterval: session['tempInterval'],
        minTemperature: session['minTemperature'],
        maxTemperature: session['maxTemperature'],
        rating: session['rating'],
      ));
    }

    return Scaffold(
      body: Container(
        color: const Color(0xFF00D9FF),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${_getGreeting()}, Timur!',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SessionPreferencesScreen(onStartSession: _addSession),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color(0xFF1E90FF),
                ),
                child: const Text(
                  'Start New Session',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              const SizedBox(height: 40),
              if (recentSessions.isEmpty) ...[
                const Text(
                  'No shower sessions yet : (',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ] else ...[
                const Text(
                  'Shower Sessions History:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 16),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  color: Colors.white,
                  child: Table(
                    border: TableBorder.all(
                      color: Colors.black,
                      width: 2,
                    ),
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1),
                      4: FlexColumnWidth(1),
                    },
                    children: [
                      TableRow(
                        children: [
                          _buildHeaderCell('Duration'),
                          _buildHeaderCell('Temp Interval'),
                          _buildHeaderCell('Min Temp'),
                          _buildHeaderCell('Max Temp'),
                          _buildHeaderCell('Rating'),
                        ],
                      ),
                      for (var session in recentSessions)
                        TableRow(
                          children: [
                            _buildDataCell('${session.duration} min'),
                            _buildDataCell('${session.temperatureInterval} sec'),
                            _buildDataCell('${session.minTemperature}°'),
                            _buildDataCell('${session.maxTemperature}°'),
                            _buildDataCell('${session.rating}'),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour > 5 && hour <= 12) {
      return 'Good morning';
    } else if (hour > 12 && hour <= 17) {
      return 'Good afternoon';
    } else if (hour > 17 && hour <= 21) {
      return 'Good evening';
    } else {
      return 'Good night';
    }
  }

  TableCell _buildHeaderCell(String text) {
    return TableCell(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  TableCell _buildDataCell(String text) {
    return TableCell(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}