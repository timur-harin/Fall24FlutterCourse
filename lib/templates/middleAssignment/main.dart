import 'dart:async';
import 'dart:convert';
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

class UserPreferences {
  final int hotDuration;
  final int coldDuration;
  final int phases;

  UserPreferences({
    required this.hotDuration,
    required this.coldDuration,
    required this.phases,
  });
}

class ShowerSession {
  final DateTime dateTime;
  final int totalTime;
  final int totalPhases;
  final int? rating;

  ShowerSession({
    required this.dateTime,
    required this.totalTime,
    required this.totalPhases,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime.toIso8601String(),
      'totalTime': totalTime,
      'totalPhases': totalPhases,
      'rating': rating,
    };
  }

  factory ShowerSession.fromMap(Map<String, dynamic> map) {
    return ShowerSession(
      dateTime: DateTime.parse(map['dateTime']),
      totalTime: map['totalTime'],
      totalPhases: map['totalPhases'],
      rating: map['rating'],
    );
  }

  String toJson() => json.encode(toMap());
  factory ShowerSession.fromJson(String source) => ShowerSession.fromMap(json.decode(source));
}

final userPreferencesProvider = StateNotifierProvider<UserPreferencesNotifier, UserPreferences>((ref) {
  return UserPreferencesNotifier();
});

final sessionHistoryProvider = StateNotifierProvider<SessionHistoryNotifier, List<ShowerSession>>((ref) {
  return SessionHistoryNotifier();
});

class UserPreferencesNotifier extends StateNotifier<UserPreferences> {
  UserPreferencesNotifier()
      : super(UserPreferences(hotDuration: 60, coldDuration: 30, phases: 5));

  void updatePreferences(int hotDuration, int coldDuration, int phases) {
    state = UserPreferences(
      hotDuration: hotDuration,
      coldDuration: coldDuration,
      phases: phases,
    );
  }
}

class SessionHistoryNotifier extends StateNotifier<List<ShowerSession>> {
  SessionHistoryNotifier() : super([]) {
    loadFromLocalStorage();
  }

  void addSession(ShowerSession session) {
    state = [...state, session];
    _saveToLocalStorage();
  }

  Future<void> _saveToLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> sessionList = state.map((session) => session.toJson()).toList();
    await prefs.setStringList('showerHistory', sessionList);
  }

  Future<void> loadFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? sessionList = prefs.getStringList('showerHistory');
    if (sessionList != null) {
      state = sessionList.map((sessionString) => ShowerSession.fromJson(sessionString)).toList();
    }
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(sessionHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contrast Shower Companion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Previous Sessions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: history.isEmpty
                  ? const Center(child: Text('No previous sessions.'))
                  : ListView.builder(
                      itemCount: history.length,
                      itemBuilder: (context, index) {
                        final session = history[index];
                        return ListTile(
                          leading: Icon(
                            Icons.history,
                            color: session.totalPhases % 2 == 0 ? Colors.blue : Colors.red,
                          ),
                          title: Text(
                            'Session on ${formatDateTime(session.dateTime)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Total Time: ${session.totalTime} seconds\nPhases: ${session.totalPhases}'),
                              if (session.rating != null)
                                Row(
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      index < session.rating! ? Icons.star : Icons.star_border,
                                      color: Colors.amber,
                                      size: 16,
                                    );
                                  }),
                                ),
                            ],
                          ),
                          isThreeLine: true,
                        );
                      },
                    ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16.0),
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
      ),
    );
  }

  String formatDateTime(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} ${formatTime(dateTime)}";
  }

  String formatTime(DateTime dateTime) {
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    String period = 'AM';
    if (hour >= 12) {
      period = 'PM';
      if (hour > 12) hour -= 12;
    }
    if (hour == 0) hour = 12;
    String minuteStr = minute < 10 ? '0$minute' : '$minute';
    return "$hour:$minuteStr $period";
  }
}

class SessionPreferencesScreen extends ConsumerWidget {
  const SessionPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(userPreferencesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Hot Duration: ${preferences.hotDuration} seconds'),
            Slider(
              value: preferences.hotDuration.toDouble(),
              min: 30,
              max: 120,
              divisions: 6,
              label: '${preferences.hotDuration} seconds',
              onChanged: (value) {
                ref.read(userPreferencesProvider.notifier).updatePreferences(
                      value.toInt(),
                      preferences.coldDuration,
                      preferences.phases,
                    );
              },
            ),
            Text('Cold Duration: ${preferences.coldDuration} seconds'),
            Slider(
              value: preferences.coldDuration.toDouble(),
              min: 15,
              max: 60,
              divisions: 3,
              label: '${preferences.coldDuration} seconds',
              onChanged: (value) {
                ref.read(userPreferencesProvider.notifier).updatePreferences(
                      preferences.hotDuration,
                      value.toInt(),
                      preferences.phases,
                    );
              },
            ),
            Text('Phases: ${preferences.phases}'),
            Slider(
              value: preferences.phases.toDouble(),
              min: 3,
              max: 10,
              divisions: 7,
              label: '${preferences.phases}',
              onChanged: (value) {
                ref.read(userPreferencesProvider.notifier).updatePreferences(
                      preferences.hotDuration,
                      preferences.coldDuration,
                      value.toInt(),
                    );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ActiveSessionScreen()),
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
  const ActiveSessionScreen({super.key});

  @override
  _ActiveSessionScreenState createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends ConsumerState<ActiveSessionScreen>
    with SingleTickerProviderStateMixin {
  late Timer _timer;
  int _remainingTime = 0;
  String _currentPhase = "Hot";
  int _completedPhases = 0;
  bool _isSessionActive = true;
  bool _isPaused = false;

  late int _hotDuration;
  late int _coldDuration;
  late int _totalPhases;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    final userPreferences = ref.read(userPreferencesProvider);

    _hotDuration = userPreferences.hotDuration;
    _coldDuration = userPreferences.coldDuration;
    _totalPhases = userPreferences.phases;

    _remainingTime = _hotDuration;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused) {
        setState(() {
          if (_remainingTime > 0) {
            _remainingTime--;
          } else {
            _switchPhase();
          }
        });
      }
    });
  }

  void _switchPhase() {
    if (_currentPhase == "Hot") {
      _currentPhase = "Cold";
      _remainingTime = _coldDuration;
    } else {
      _currentPhase = "Hot";
      _remainingTime = _hotDuration;
    }

    _completedPhases++;
    if (_completedPhases >= _totalPhases) {
      _endSession();
    }
  }

  void _endSession() {
  _timer.cancel();
  _animationController.stop();
  setState(() {
    _isSessionActive = false;
  });

  int hotPhases = (_totalPhases + 1) ~/ 2;
  int coldPhases = _totalPhases ~/ 2;
  int totalTime = (hotPhases * _hotDuration) + (coldPhases * _coldDuration);

  final session = ShowerSession(
    dateTime: DateTime.now(),
    totalTime: totalTime,
    totalPhases: _totalPhases,
  );

  _showRatingDialog(session);
}

void _showRatingDialog(ShowerSession session) {
  int _selectedRating = 3;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text('Rate Your Experience'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Total Time: ${session.totalTime} seconds'),
                Text('Phases Completed: ${session.totalPhases}'),
                const SizedBox(height: 20),
                const Text('How would you rate your contrast shower session?'),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < _selectedRating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                      ),
                      onPressed: () {
                        setDialogState(() {
                          _selectedRating = index + 1;
                        });
                      },
                    );
                  }),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  final ratedSession = ShowerSession(
                    dateTime: session.dateTime,
                    totalTime: session.totalTime,
                    totalPhases: session.totalPhases,
                    rating: _selectedRating,
                  );
                  ref.read(sessionHistoryProvider.notifier).addSession(ratedSession);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('Submit'),
              ),
            ],
          );
        },
      );
    },
  );
}

  void _togglePauseResume() {
    setState(() {
      _isPaused = !_isPaused;
      if (_isPaused) {
        _animationController.stop();
      } else {
        _animationController.repeat();
      }
    });
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
      appBar: AppBar(
        title: const Text('Active Session'),
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: _currentPhase == "Hot" ? Colors.red[100] : Colors.blue[100],
        child: Center(
          child: _isSessionActive
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RotationTransition(
                      turns: _animationController,
                      child: Icon(
                        Icons.autorenew,
                        size: 100,
                        color: _currentPhase == "Hot" ? Colors.red : Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Current Phase: $_currentPhase',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Remaining Time: $_remainingTime seconds',
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Remaining Phases: ${_totalPhases - _completedPhases}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _togglePauseResume,
                      child: Text(_isPaused ? 'Resume' : 'Pause'),
                    ),
                  ],
                )
              : const Text(
                  'Session Complete!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }
}
