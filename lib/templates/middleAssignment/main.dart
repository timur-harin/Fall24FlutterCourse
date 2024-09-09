import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ProviderScope(child: MiddleAssigmentApp()));
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contrast Shower Companion',
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
        title: const Text('Contrast Shower Companion'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: sessionHistory.length,
              itemBuilder: (context, index) {
                final session = sessionHistory[index];
                return ListTile(
                  title: Text('Session ${index + 1}'),
                  subtitle: Text('Duration: ${session.duration} min, Phases: ${session.phases}'),
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
                  MaterialPageRoute(builder: (context) => const SessionPreferencesScreen()),
                );
              },
              child: const Text('Start New Session'),
            ),
          ),
        ],
      ),
    );
  }
}

class SessionPreferencesScreen extends StatefulWidget {
  const SessionPreferencesScreen({super.key});

  @override
  _SessionPreferencesScreenState createState() => _SessionPreferencesScreenState();
}

class _SessionPreferencesScreenState extends State<SessionPreferencesScreen> {
  int _duration = 10; // Default duration in minutes
  int _phases = 3; // Default number of phases

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Duration: $_duration minutes'),
            Slider(
              value: _duration.toDouble(),
              min: 1,
              max: 30,
              divisions: 10,
              label: '$_duration min',
              onChanged: (value) {
                setState(() {
                  _duration = value.toInt();
                });
              },
            ),
            Text('Phases: $_phases'),
            Slider(
              value: _phases.toDouble(),
              min: 1,
              max: 5,
              divisions: 4,
              label: '$_phases',
              onChanged: (value) {
                setState(() {
                  _phases = value.toInt();
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActiveSessionScreen(
                      duration: _duration,
                      phases: _phases,
                    ),
                  ),
                );
              },
              child: const Text('Begin Session'),
            ),
          ],
        ),
      ),
    );
  }
}

class ActiveSessionScreen extends ConsumerStatefulWidget {
  final int duration;
  final int phases;

  const ActiveSessionScreen({super.key, required this.duration, required this.phases});

  @override
  _ActiveSessionScreenState createState() => _ActiveSessionScreenState();
}
class _ActiveSessionScreenState extends ConsumerState<ActiveSessionScreen> with SingleTickerProviderStateMixin {
  late int _remainingTime;
  late Timer _timer;
  late AnimationController _animationController;
  int _currentPhase = 1;
  bool _isHotPhase = true;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.duration * 60; // Convert minutes to seconds
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused) {
        setState(() {
          if (_remainingTime > 0) {
            _remainingTime--;
          } else {
            if (_currentPhase < widget.phases) {
              _currentPhase++;
              _isHotPhase = !_isHotPhase;
              _remainingTime = widget.duration * 60;
              _animationController.forward(from: 0);
            } else {
              _endSession();
            }
          }
        });
      }
    });
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _endSession() {
    _timer.cancel();
    final showerSession = ShowerSession(duration: widget.duration, phases: widget.phases);
    ref.read(sessionHistoryProvider.notifier).addSession(showerSession);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SessionSummaryScreen()),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isHotPhase ? Colors.red : Colors.blue,
      appBar: AppBar(
        title: const Text('Active Session'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _animationController,
              child: Text(
                'Current Phase: ${_isHotPhase ? 'Hot' : 'Cold'}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Text('Remaining Time: ${_remainingTime ~/ 60}:${(_remainingTime % 60).toString().padLeft(2, '0')}', 
            style: const TextStyle(fontSize: 24)),
            ElevatedButton(
              onPressed: _togglePause,
              child: Text(_isPaused ? 'Resume' : 'Pause'),
            ),
            ElevatedButton(
              onPressed: _endSession,
              child: const Text('End Session'),
            ),
          ],
        ),
      ),
    );
  }
}

class SessionSummaryScreen extends StatelessWidget {
  const SessionSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Summary'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Total Time: 10 min'),
            const Text('Phases Completed: 3'),
            const Text('Rate your experience:'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(Icons.star_border),
                  onPressed: () {
                    // Handle rating logic
                  },
                );
              }),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

// State Management with Riverpod
final sessionHistoryProvider = StateNotifierProvider<SessionHistoryNotifier, List<ShowerSession>>((ref) {
  return SessionHistoryNotifier();
});

class SessionHistoryNotifier extends StateNotifier<List<ShowerSession>> {
  SessionHistoryNotifier() : super([]);
  void addSession(ShowerSession session) {
    state = [session, ...state];
    _saveToLocalStorage();
  }

  Future<void> _saveToLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionData = state.map((session) => session.toJson()).toList();
    prefs.setString('sessionHistory', sessionData.toString());
  }

  Future<void> loadFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionData = prefs.getString('sessionHistory');
    if (sessionData != null) {
      // Deserialize and update state
    }
  }
}

class ShowerSession {
  final int duration;
  final int phases;

  ShowerSession({required this.duration, required this.phases});

  Map<String, dynamic> toJson() {
    return {
      'duration': duration,
      'phases': phases,
    };
  }
}