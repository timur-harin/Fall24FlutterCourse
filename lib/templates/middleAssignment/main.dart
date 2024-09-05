import 'dart:async';
import 'dart:convert'; // Import for JSON encoding/decoding
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Entry Point
void main() {
  runApp(const ProviderScope(child: MiddleAssigmentApp()));
}

// App Class
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

// User Preferences Model
class UserPreferences {
  final int hotDuration; // in seconds
  final int coldDuration; // in seconds
  final int phases;

  UserPreferences({
    required this.hotDuration,
    required this.coldDuration,
    required this.phases,
  });
}

// Session Model
class ShowerSession {
  final DateTime dateTime;
  final int totalTime;
  final int totalPhases;
  final int? rating; // Optional rating field (can be null if user skips rating)

  ShowerSession({
    required this.dateTime,
    required this.totalTime,
    required this.totalPhases,
    this.rating,
  });

  // Convert ShowerSession to a Map
  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime.toIso8601String(),
      'totalTime': totalTime,
      'totalPhases': totalPhases,
      'rating': rating,
    };
  }

  // Create ShowerSession from a Map
  factory ShowerSession.fromMap(Map<String, dynamic> map) {
    return ShowerSession(
      dateTime: DateTime.parse(map['dateTime']),
      totalTime: map['totalTime'],
      totalPhases: map['totalPhases'],
      rating: map['rating'],
    );
  }

  // Convert ShowerSession to JSON string
  String toJson() => json.encode(toMap());

  // Create ShowerSession from JSON string
  factory ShowerSession.fromJson(String source) => ShowerSession.fromMap(json.decode(source));
}

// Riverpod Providers
final userPreferencesProvider = StateNotifierProvider<UserPreferencesNotifier, UserPreferences>((ref) {
  return UserPreferencesNotifier();
});

final sessionHistoryProvider = StateNotifierProvider<SessionHistoryNotifier, List<ShowerSession>>((ref) {
  return SessionHistoryNotifier();
});

// User Preferences StateNotifier
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

// Session History StateNotifier
class SessionHistoryNotifier extends StateNotifier<List<ShowerSession>> {
  SessionHistoryNotifier() : super([]) {
    loadFromLocalStorage();
  }

  // Add a new session and save to local storage
  void addSession(ShowerSession session) {
    state = [...state, session];
    _saveToLocalStorage();
  }

  // Save sessions to SharedPreferences
  Future<void> _saveToLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> sessionList = state.map((session) => session.toJson()).toList();
    await prefs.setStringList('showerHistory', sessionList);
  }

  // Load sessions from SharedPreferences
  Future<void> loadFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? sessionList = prefs.getStringList('showerHistory');
    if (sessionList != null) {
      state = sessionList.map((sessionString) => ShowerSession.fromJson(sessionString)).toList();
    }
  }
}

// Home Screen
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
              margin: const EdgeInsets.only(bottom: 16.0), // Add bottom margin
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

  // Helper method to format DateTime
  String formatDateTime(DateTime dateTime) {
    // Example format: Sep 5, 2024, 10:30 AM
    return "${dateTime.month}/${dateTime.day}/${dateTime.year} ${formatTime(dateTime)}";
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

// Session Preferences Screen
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
            // Hot Duration Slider
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
            // Cold Duration Slider
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
            // Phases Slider
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

// Active Session Screen
class ActiveSessionScreen extends ConsumerStatefulWidget {
  const ActiveSessionScreen({super.key});

  @override
  _ActiveSessionScreenState createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends ConsumerState<ActiveSessionScreen>
    with SingleTickerProviderStateMixin {
  late Timer _timer;
  int _remainingTime = 0;
  String _currentPhase = "Hot"; // Hot or Cold
  int _completedPhases = 0;
  bool _isSessionActive = true;
  bool _isPaused = false; // New flag for pause state

  late int _hotDuration;
  late int _coldDuration;
  late int _totalPhases;

  // Animation variables
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    // Get user preferences from Riverpod
    final userPreferences = ref.read(userPreferencesProvider);

    _hotDuration = userPreferences.hotDuration;
    _coldDuration = userPreferences.coldDuration;
    _totalPhases = userPreferences.phases;

    _remainingTime = _hotDuration;

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Rotate every 3 seconds
    )..repeat(); // Repeat indefinitely

    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused) { // Update only if not paused
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
  _animationController.stop(); // Stop the animation when session ends
  setState(() {
    _isSessionActive = false;
  });

  // Calculate total time
  int hotPhases = (_totalPhases + 1) ~/ 2;
  int coldPhases = _totalPhases ~/ 2;
  int totalTime = (hotPhases * _hotDuration) + (coldPhases * _coldDuration);

  // Create session without rating yet
  final session = ShowerSession(
    dateTime: DateTime.now(),
    totalTime: totalTime,
    totalPhases: _totalPhases,
  );

  // Prompt user to rate their experience
  _showRatingDialog(session);
}

void _showRatingDialog(ShowerSession session) {
  int _selectedRating = 3; // Default rating value

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
                          _selectedRating = index + 1; // Update the rating
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
                  // Add session with the selected rating
                  final ratedSession = ShowerSession(
                    dateTime: session.dateTime,
                    totalTime: session.totalTime,
                    totalPhases: session.totalPhases,
                    rating: _selectedRating,
                  );
                  ref.read(sessionHistoryProvider.notifier).addSession(ratedSession);
                  Navigator.pop(context); // Close the dialog
                  Navigator.pop(context); // Navigate back to HomeScreen
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
        _animationController.stop(); // Stop animation when paused
      } else {
        _animationController.repeat(); // Resume animation when unpaused
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
        duration: const Duration(milliseconds: 500), // Smooth transition
        color: _currentPhase == "Hot" ? Colors.red[100] : Colors.blue[100], // Background color
        child: Center(
          child: _isSessionActive
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RotationTransition(
                      turns: _animationController, // Add the custom animation here
                      child: Icon(
                        Icons.autorenew, // Icon to rotate
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
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _togglePauseResume, // Pause/Resume button
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

