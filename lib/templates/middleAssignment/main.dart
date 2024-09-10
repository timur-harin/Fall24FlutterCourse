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
                final session = sessionHistory[index].split('|');
                if (session[2].replaceAll(RegExp(r'\s+'), '') == "1") {
                  return ListTile(
                  title: Text('Session ${sessionHistory.length - index}'),
                  subtitle: Text(
                    'Duration: ${session[0]} min, Phases: ${session[1]} \nRating: ⭐️',
                    style: const TextStyle(fontSize: 16),
                  ),
                );
                } else if (session[2].replaceAll(RegExp(r'\s+'), '') == "2") {
                  return ListTile(
                  title: Text('Session ${sessionHistory.length - index}'),
                  subtitle: Text(
                    'Duration: ${session[0]} min, Phases: ${session[1]} \nRating: ⭐️⭐️',
                    style: const TextStyle(fontSize: 16),
                  ),
                );
                } else if (session[2].replaceAll(RegExp(r'\s+'), '') == "3") {
                  return ListTile(
                  title: Text('Session ${sessionHistory.length - index}'),
                  subtitle: Text(
                    'Duration: ${session[0]} min, Phases: ${session[1]} \nRating: ⭐️⭐️⭐️',
                    style: const TextStyle(fontSize: 16),
                  ),
                );
                } else if (session[2].replaceAll(RegExp(r'\s+'), '') == "4") {
                  return ListTile(
                  title: Text('Session ${sessionHistory.length - index}'),
                  subtitle: Text(
                    'Duration: ${session[0]} min, Phases: ${session[1]} \nRating: ⭐️⭐️⭐️⭐️',
                    style: const TextStyle(fontSize: 16),
                  ),
                );
                } else {
                  return ListTile(
                  title: Text('Session ${sessionHistory.length - index}'),
                  subtitle: Text(
                    'Duration: ${session[0]} min, Phases: ${session[1]} \nRating: ⭐️⭐️⭐️⭐️⭐️',
                    style: const TextStyle(fontSize: 16),
                  ),
                );
                }
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
  int _duration = 10;
  int _phases = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
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
  int _currentPhase = 1;
  bool _isHotPhase = true;
  bool _isPaused = false;
  int _rating = 0;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.duration * 60; // Convert minutes to seconds
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

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Session'),
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        color: _isHotPhase ? Colors.red : Colors.blue,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Current Phase: ${_isHotPhase ? "Hot" : "Cold"}',
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text('Phase $_currentPhase of ${widget.phases}', style: const TextStyle(fontSize: 20)),
              Text('Remaining Time: ${_remainingTime ~/ 60}:${(_remainingTime % 60).toString().padLeft(2, '0')}', 
              style: const TextStyle(fontSize: 30)),
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
          )
        )
      ),
    );
  }

  void _endSession() {
    _timer.cancel();
    _showRatingDialog();
  }

  Future<void> _showRatingDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Rate Your Experience'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      _rating > index ? Icons.star : Icons.star_border,
                      color: Colors.yellow,
                    ),
                    onPressed: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                  );
                }),
              );
            },
          ),

          actions: <Widget>[
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                _saveSession(widget.duration, widget.phases, _rating);
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveSession(int duration, int phases, int rating) async {
    final sessionSummary = '$duration | $phases | $rating';
    await ref.read(sessionHistoryProvider.notifier).saveToLocalStorage(sessionSummary);
  }
}

// State Management with Riverpod
final sessionHistoryProvider = StateNotifierProvider<SessionHistoryNotifier, List<String>>((ref) {
  return SessionHistoryNotifier();
});

class SessionHistoryNotifier extends StateNotifier<List<String>> {
  SessionHistoryNotifier() : super([]) {
    loadFromLocalStorage();
  }

  void setHistory(List<String> newHistory) {
    state = newHistory;
  }

  Future<void> saveToLocalStorage(String session) async {
    final prefs = await SharedPreferences.getInstance();
    state = [session, ...state];
    await prefs.setStringList('sessionHistory', state);
  }

  Future<void> loadFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getStringList('sessionHistory') ?? [];
  }
}