import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; 
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ProviderScope(child: ContrastShowerApp()));
}

class ContrastShowerApp extends StatelessWidget {
  const ContrastShowerApp({super.key});

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

final sessionHistoryProvider = StateNotifierProvider<SessionHistoryNotifier, List<String>>((ref) {
  return SessionHistoryNotifier();
});

class SessionHistoryNotifier extends StateNotifier<List<String>> {
  SessionHistoryNotifier() : super([]) {
    _loadSessionHistory();
  }

  void setHistory(List<String> newHistory) {
    state = newHistory;
  }

  Future<void> _loadSessionHistory() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getStringList('sessionHistory') ?? [];
  }

  Future<void> addToHistory(String session) async {
    final prefs = await SharedPreferences.getInstance();
    state = [session, ...state];
    await prefs.setStringList('sessionHistory', state);
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
                return ListTile(
                  title: Text(
                    'Session ${index + 1}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  subtitle: Text(
                    'Duration: ${session[0]} min, Phases: ${session[1]} \nRating: ${session[2]}⭐️',
                    style: const TextStyle(fontSize: 16),
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
                  MaterialPageRoute(builder: (context) => const SessionPreferencesScreen()),
                );
              },
              child: const Text('Start New Session', style: TextStyle(fontSize: 18)),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Duration: $_duration minutes', style: const TextStyle(fontSize: 18)),
            Slider(
              value: _duration.toDouble(),
              min: 1,
              max: 30,
              divisions: 29,
              label: '$_duration min',
              onChanged: (value) {
                setState(() {
                  _duration = value.toInt();
                });
              },
            ),
            Text('Phases: $_phases', style: const TextStyle(fontSize: 18)),

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
                    builder: (context) => SessionOverviewScreen(
                      duration: _duration,
                      phases: _phases,
                    ),
                  ),
                );
              },
              child: const Text('Next', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

class SessionOverviewScreen extends StatelessWidget {
  final int duration;
  final int phases;

  const SessionOverviewScreen({super.key, required this.duration, required this.phases});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Overview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Duration: $duration minutes', style: const TextStyle(fontSize: 18)),
            Text('Phases: $phases', style: const TextStyle(fontSize: 18)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActiveSessionScreen(
                      duration: duration,
                      phases: phases,
                    ),
                  ),
                );
              },
              child: const Text('Begin Session', style: TextStyle(fontSize: 18)),
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

class _ActiveSessionScreenState extends ConsumerState<ActiveSessionScreen> {
  Timer? _timer;
  int _elapsedTime = 0;
  int _currentPhase = 1;
  bool isHotPhase = true;
  int _rating = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime++;
        final phaseDuration = (widget.duration * 60) ~/ widget.phases;
        if (_elapsedTime >= phaseDuration) {
          _elapsedTime = 0;
          if (_currentPhase < widget.phases) {
            _currentPhase++;
            isHotPhase = !isHotPhase;
          } else {
            _completeSession();
          }
        }
      });
    });
  }

  void _completeSession() {
    _timer?.cancel();
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
    await ref.read(sessionHistoryProvider.notifier).addToHistory(sessionSummary);
  }

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Session'),
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: isHotPhase ? Colors.red.shade200 : Colors.blue.shade200,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Current Phase: ${isHotPhase ? "Hot" : "Cold"}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text('Phase $_currentPhase of ${widget.phases}', style: const TextStyle(fontSize: 20)),
                Text('Elapsed time: $_elapsedTime seconds', style: const TextStyle(fontSize: 20)),
                ElevatedButton(
                  onPressed: _completeSession,
                  child: const Text('End Session', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
