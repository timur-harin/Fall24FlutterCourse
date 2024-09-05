import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(const MiddleAssigmentApp());
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Middle Assigment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionHistory = ref.watch(sessionHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Middle Assignment'),
      ),
      body: ListView.builder(
        itemCount: sessionHistory.length,
        itemBuilder: (context, index) {
          final session = sessionHistory[index];
          return ListTile(
            title: Text('Session on ${session.startTime}'),
            subtitle: Text('Duration: ${session.totalDuration.inMinutes} minutes'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SessionDetailScreen(session: session),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PreferencesScreen()),
          );
        },
        child: const Icon(Icons.add),
        tooltip: 'Start New Session',
      ),
    );
  }
}

class TemperaturePhase {
  final String type; // "hot" or "cold"
  final Duration duration;

  TemperaturePhase({
    required this.type,
    required this.duration,
  });

  // Factory constructor to create a TemperaturePhase from JSON
  factory TemperaturePhase.fromJson(Map<String, dynamic> json) {
    return TemperaturePhase(
      type: json['type'],
      duration: Duration(seconds: json['duration']),
    );
  }

  // Method to convert TemperaturePhase to JSON
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'duration': duration.inSeconds,
    };
  }

  @override
  String toString() {
    return 'TemperaturePhase(type: $type, duration: ${duration.inSeconds} seconds)';
  }

  // Method to check if the phase is hot or cold
  bool get isHot => type == 'hot';
  bool get isCold => type == 'cold';
}

class ShowerSession {
  final DateTime startTime;
  final List<TemperaturePhase> phases;
  final Duration totalDuration;
  Duration elapsedTime = Duration.zero;

  ShowerSession({
    required this.startTime,
    required this.phases,
    required this.totalDuration,
  });

  TemperaturePhase get currentPhase {
    Duration accumulatedDuration = Duration.zero;
    for (var phase in phases) {
      accumulatedDuration += phase.duration;
      if (elapsedTime <= accumulatedDuration) {
        return phase;
      }
    }
    return phases.last;
  }

  Duration get remainingTime {
    Duration accumulatedDuration = Duration.zero;
    for (var phase in phases) {
      accumulatedDuration += phase.duration;
      if (elapsedTime <= accumulatedDuration) {
        return accumulatedDuration - elapsedTime;
      }
    }
    return Duration.zero;
  }

  void updateElapsedTime(Duration newTime) {
    elapsedTime = newTime;
  }

  void displaySessionDetails() {
    print('Shower Session started at: $startTime');
    print('Total Duration: ${totalDuration.inMinutes} minutes');
    for (var phase in phases) {
      print('Phase: ${phase.type}, Duration: ${phase.duration.inSeconds} seconds');
    }
  }
}

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Set Session Preferences')),
      body: Center(
        child: Column(
          children: [
            // Widgets for setting duration, temperature intervals, etc.
            ElevatedButton(
              onPressed: () {
                // Move to Session Overview
              },
              child: const Text('Continue to Overview'),
            ),
          ],
        ),
      ),
    );
  }
}

class ActiveSessionScreen extends StatelessWidget {
  final ShowerSession session;

  const ActiveSessionScreen({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Session'),
        actions: [
          IconButton(
            icon: const Icon(Icons.stop),
            onPressed: () {
              // End session early
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomAnimatedWidget(session: session),
            Text('Current Phase: ${session.currentPhase.type}'),
            Text('Time Remaining: ${session.remainingTime.inSeconds} seconds'),
          ],
        ),
      ),
    );
  }
}


class CustomAnimatedWidget extends StatelessWidget {
  final ShowerSession session;

  const CustomAnimatedWidget({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TemperatureTransitionPainter(session: session),
      child: Container(
        height: 200,
        width: double.infinity,
      ),
    );
  }
}

class TemperatureTransitionPainter extends CustomPainter {
  final ShowerSession session;

  TemperatureTransitionPainter({required this.session});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    double phaseWidth = size.width / session.phases.length;

    for (int i = 0; i < session.phases.length; i++) {
      final phase = session.phases[i];
      paint.color = phase.type == 'hot' ? Colors.red : Colors.blue;
      canvas.drawRect(
        Rect.fromLTWH(i * phaseWidth, 0, phaseWidth, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class LocalStorageService {
  Future<void> saveSessionHistory(List<ShowerSession> sessions) async {
    final prefs = await SharedPreferences.getInstance();
    final sessionListJson = sessions.map((session) {
      return {
        'startTime': session.startTime.toIso8601String(),
        'totalDuration': session.totalDuration.inSeconds,
        'phases': session.phases.map((phase) {
          return {
            'type': phase.type,
            'duration': phase.duration.inSeconds,
          };
        }).toList(),
      };
    }).toList();

    prefs.setString('sessionHistory', jsonEncode(sessionListJson));
  }

  Future<List<ShowerSession>> getSessionHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionHistoryString = prefs.getString('sessionHistory');

    if (sessionHistoryString == null) {
      return [];
    }

    final sessionList = jsonDecode(sessionHistoryString) as List<dynamic>;

    return sessionList.map((sessionJson) {
      final phases = (sessionJson['phases'] as List<dynamic>).map((phaseJson) {
        return TemperaturePhase(
          type: phaseJson['type'],
          duration: Duration(seconds: phaseJson['duration']),
        );
      }).toList();

      return ShowerSession(
        startTime: DateTime.parse(sessionJson['startTime']),
        totalDuration: Duration(seconds: sessionJson['totalDuration']),
        phases: phases,
      );
    }).toList();
  }
}

class SessionDetailScreen extends StatelessWidget {
  final ShowerSession session;

  const SessionDetailScreen({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Details'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Session started on: ${session.startTime}'),
            Text('Total Duration: ${session.totalDuration.inMinutes} minutes'),
            ...session.phases.map((phase) => Text(
                'Phase: ${phase.type}, Duration: ${phase.duration.inSeconds} seconds')),
          ],
        ),
      ),
    );
  }
}

final sessionHistoryProvider = StateNotifierProvider<SessionHistoryNotifier, List<ShowerSession>>((ref) {
  return SessionHistoryNotifier();
});

class SessionHistoryNotifier extends StateNotifier<List<ShowerSession>> {
  SessionHistoryNotifier() : super([]);

  void addSession(ShowerSession session) {
    state = [...state, session];
    // Save to local storage
  }
}
