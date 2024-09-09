import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(
    const ProviderScope(child: MiddleAssigmentApp()));
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
        title: const Text('Home'),
      ),
      body:sessionHistory.isEmpty
      ? const Center(child: Text('No sessions found'))
      : ListView.builder(
        itemCount: sessionHistory.length,
        itemBuilder: (context, index) {
          final session = sessionHistory[index];
          return ListTile(
            title: Text('Session on ${DateFormat('MM/dd/yyyy hh:mm a').format(session.startTime)}'),
            subtitle: Text('Duration: ${session.totalDuration.inSeconds} '),
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
        tooltip: 'Start New Session',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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


  bool get isHot => type == 'Hot';
  bool get isCold => type == 'Cold';
}

class ShowerSession {
  final DateTime startTime;
  final List<TemperaturePhase> phases;
  final Duration totalDuration;
  Duration elapsedTime = Duration.zero;
  double? rating;
  int currentPhaseInx = 0;

  ShowerSession({
    required this.startTime,
    required this.phases,
    required this.totalDuration,
    this.rating,
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
    Duration accumulatedDuration = totalDuration;
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

final sessionPreferencesProvider = StateNotifierProvider<SessionPreferencesNotifier, SessionPreferences>((ref) {
  return SessionPreferencesNotifier();
});

class PreferencesScreen extends ConsumerStatefulWidget {
  const PreferencesScreen({super.key});

  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends ConsumerState<PreferencesScreen> {
  final List<TemperaturePhase> _phases = [];
  String _selectedType = 'Hot'; // Define the selectedType variable
  int _selectedDuration = 60;

  void _addPhase() {
    setState(() {
      _phases.add(TemperaturePhase(type: _selectedType, duration: Duration(seconds: _selectedDuration)));
    });
  }

  void _savePreferences() {
    final startTime = DateTime.now();
    final totalDuration = _phases.fold(Duration.zero, (sum, phase) => sum + phase.duration);
    final session = ShowerSession(
      startTime: startTime,
      phases: _phases,
      totalDuration: totalDuration,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SessionOverviewScreen(session: session),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sessionPreferences = ref.watch(sessionPreferencesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Set Session Preferences')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Session Duration (minutes):'),
            Slider(
              value: sessionPreferences.duration.toDouble(),
              min: 5,
              max: 60,
              divisions: 11,
              label: sessionPreferences.duration.toString(),
              onChanged: (value) {
                ref.read(sessionPreferencesProvider.notifier).updateDuration(value.toInt());
              },
            ),
            const SizedBox(height: 20),
            const Text('Temperature Phases:'),
            Row(
              children: [
                DropdownButton<String>(
                  value: _selectedType,
                  items: const [
                    DropdownMenuItem(value: 'Hot', child: Text('Hot')),
                    DropdownMenuItem(value: 'Cold', child: Text('Cold')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedType = value!;
                    });
                  },
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Slider(
                    value: _selectedDuration.toDouble(),
                    min: 10,
                    max: 600,
                    divisions: 59,
                    label: '$_selectedDuration seconds',
                    onChanged: (value) {
                      setState(() {
                        _selectedDuration = value.toInt();
                      });
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: _addPhase,
                  child: const Text('Add Phase'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _phases.length,
                itemBuilder: (context, index) {
                  final phase = _phases[index];
                  return ListTile(
                    title: Text('${phase.type} - ${phase.duration.inSeconds} seconds'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _phases.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _savePreferences,
              child: const Text('Continue to Overview'),
            ),
          ],
        ),
      ),
    );
  }
}


// Preferences model class
class SessionPreferences {
  final int duration;
  final String temperature;

  SessionPreferences({
    required this.duration,
    required this.temperature,
  });

  SessionPreferences copyWith({
    int? duration,
    String? temperature,
  }) {
    return SessionPreferences(
      duration: duration ?? this.duration,
      temperature: temperature ?? this.temperature,
    );
  }
}

// Preferences state notifier
class SessionPreferencesNotifier extends StateNotifier<SessionPreferences> {
  SessionPreferencesNotifier()
      : super(SessionPreferences(duration: 15, temperature: 'Hot'));

  void updateDuration(int newDuration) {
    state = state.copyWith(duration: newDuration);
  }

  void updateTemperature(String newTemperature) {
    state = state.copyWith(temperature: newTemperature);
  }
}

class SessionOverviewScreen extends StatelessWidget {
  final ShowerSession session;

  const SessionOverviewScreen({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Overview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Start Time: ${session.startTime}'),
            Text('Total Duration: ${session.totalDuration} seconds'),
            const SizedBox(height: 20),
            const Text('Temperature Phases:'),
            ...session.phases.map((phase) => Text('${phase.type}: ${phase.duration.inSeconds} seconds')),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the ActiveSessionScreen to start the session
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActiveSessionScreen(session: session),
                    ),
                  );
                },
                child: const Text('Begin Session'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActiveSessionScreen extends StatefulWidget {
  final ShowerSession session;

  const ActiveSessionScreen({super.key, required this.session});

  @override
  _ActiveSessionScreenState createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends State<ActiveSessionScreen> {
  late ShowerSession _session;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _session = widget.session;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _session.updateElapsedTime(_session.elapsedTime + Duration(seconds: 1));
      });
      
      if (_session.remainingTime <= Duration.zero) {
        _timer.cancel();
        _navigateToSummary();
      }
    });
  }

  void _pauseSession() {
    _timer.cancel();
  }

  void _endSession() {
    _timer.cancel();
    _navigateToSummary();
  }

  void _navigateToSummary() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SessionSummaryScreen(session: _session),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Session'),
        actions: [
          IconButton(
            icon: const Icon(Icons.stop),
            onPressed: _endSession,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomAnimatedWidget(session: _session),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _session.phases.length,
                itemBuilder: (context, index) {
                  final phase = _session.phases[index];
                  bool isCurrentPhase = phase == _session.currentPhase;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    color: isCurrentPhase ? Colors.yellow.shade100 : null, 
                    child: ListTile(
                      title: Text(
                        'Phase ${index + 1}: ${phase.type}',
                        style: TextStyle(
                          color: phase.isHot ? Colors.red : Colors.blue,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text('Duration ${phase.duration} seconds'),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pauseSession,
              child: const Text('Pause Session'),
            ),
            ElevatedButton(
              onPressed: _startTimer,
              child: const Text('Resume Session'),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}


class CustomAnimatedWidget extends StatelessWidget {
  final ShowerSession session;

  const CustomAnimatedWidget({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TemperatureTransitionPainter(session: session),
      child: const SizedBox(
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
      paint.color = phase.type == 'Hot' ? Colors.red : Colors.blue;
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

class SessionSummaryScreen extends ConsumerStatefulWidget {
  final ShowerSession session;

  const SessionSummaryScreen({super.key, required this.session});

  @override
  _SessionSummaryScreenState createState() => _SessionSummaryScreenState();
}

class _SessionSummaryScreenState extends ConsumerState<SessionSummaryScreen> {
  double _rating = 0.0;

  void _submitSession() {
    setState(() {
      widget.session.rating = _rating;
    });

     ref.read(sessionHistoryProvider.notifier).addSession(widget.session);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text('Session Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Time: ${widget.session.totalDuration} seconds'),
            Text('Phases Completed: ${widget.session.phases.length}'),
            const SizedBox(height: 20),
            const Text('Rate your experience:'),
            const SizedBox(height: 10),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitSession,
              child: const Text('Submit Session'),
            ),
          ],
        ),
      ),
    );
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
            Text('Total Duration: ${session.totalDuration.inSeconds} seconds'),
            Text('Rating: ${session.rating?.toStringAsFixed(1) ?? 'Not Rated'} stars'),
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
  List<ShowerSession> get history => state;
}
