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
        title: const Icon(Icons.home, color: Colors.white),
        backgroundColor: Colors.teal,
      ),
      body: sessionHistory.isEmpty
          ? const Center(
              child: Text(
                'No sessions found',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: sessionHistory.length,
              itemBuilder: (context, index) {
                final session = sessionHistory[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: const Icon(Icons.shower, color: Colors.teal),
                    title: Text(
                      'Session on ${DateFormat('MM/dd/yyyy hh:mm a').format(session.startTime)}',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    subtitle: Text(
                      'Duration: ${session.totalDuration.inMinutes} minutes, Phases: ${session.phases.length}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, color: Colors.teal),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SessionDetailScreen(session: session),
                        ),
                      );
                    },
                  ),
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
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            '+',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
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
  String _selectedType = 'Hot'; 
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
      appBar: 
      AppBar(title: const Text('Set Session Preferences'),
              backgroundColor: Colors.teal,),
      body: 
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.tealAccent, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text('Temperature Phases:', 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            Row(
              children: [
                DropdownButton<String>(
                  value: _selectedType,
                  dropdownColor: Colors.teal,
                  style: const TextStyle(color: Colors.white),
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
                    min: 5,
                    max: 300,
                    divisions: 60,
                    label: '$_selectedDuration seconds',
                    activeColor: Colors.teal,
                    inactiveColor: Colors.teal.shade100,
                    onChanged: (value) {
                      setState(() {
                        _selectedDuration = value.toInt();
                      });
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: _addPhase,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  child: const Text('Add Phase', style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _phases.length,
                itemBuilder: (context, index) {
                  final phase = _phases[index];
                  return Card(
                      color: Colors.white.withOpacity(0.7),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        title: Text('${phase.type} - ${phase.duration.inSeconds} seconds'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () {
                            setState(() {
                              _phases.removeAt(index);
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            const Spacer(),
            ElevatedButton(
              onPressed: _savePreferences,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              child: const Text('Continue', style: TextStyle(fontSize: 16, color: Colors.white)),
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
        backgroundColor: Colors.teal,
      ),
      body:  Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.tealAccent, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Start Time: ${session.startTime}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Total Duration: ${session.totalDuration.inSeconds} seconds',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Temperature Phases:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: session.phases.length,
                  itemBuilder: (context, index) {
                    final phase = session.phases[index];
                    return Card(
                      color: Colors.white.withOpacity(0.7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        title: Text(
                          '${phase.type}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          '${phase.duration.inSeconds} seconds',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ActiveSessionScreen(session: session),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Begin Session',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
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
   bool _isPaused = false;

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
    setState(() {
      _isPaused = true;
    });
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
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.stop, color: Colors.white),
            onPressed: _endSession,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.tealAccent, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                      color: isCurrentPhase ? Colors.yellow.shade100 : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        title: Text(
                          'Phase ${index + 1}: ${phase.type}',
                          style: TextStyle(
                            color: phase.isHot ? Colors.red : Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Duration ${phase.duration.inSeconds} seconds',
                          style: const TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        trailing: isCurrentPhase
                            ? const Icon(Icons.timelapse, color: Colors.orange)
                            : null,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _isPaused ? _startTimer : _pauseSession,
                    icon: Icon(_isPaused ? Icons.play_arrow : Icons.pause),
                    label: Text(_isPaused ? 'Resume' : 'Pause'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: _endSession,
                    icon: const Icon(Icons.stop),
                    label: const Text('End Session'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
  final phaseWidth = size.width / session.phases.length;

  for (int i = 0; i < session.phases.length; i++) {
    final phase = session.phases[i];
    final gradient = LinearGradient(
      colors: phase.type == 'Hot' 
        ? [Colors.red, Colors.orangeAccent] 
        : [Colors.blue, Colors.lightBlueAccent],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final paint = Paint()..shader = gradient.createShader(
        Rect.fromLTWH(i * phaseWidth, 0, phaseWidth, size.height)
    );

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(i * phaseWidth, 0, phaseWidth, size.height),
      const Radius.circular(10),
    );

    canvas.drawRRect(rect, paint);
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
      appBar: AppBar(title: const Text('Session Summary'),
                      backgroundColor: Colors.teal,),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Session Summary',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Time: ${widget.session.totalDuration} seconds',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Phases Completed: ${widget.session.phases.length}',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Rate your experience:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
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
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: _submitSession,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  backgroundColor: Colors.teal,
                ),
                child: const Text(
                  'Submit Session',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
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
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Session Overview',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: const Icon(Icons.access_time, color: Colors.teal),
                title: Text(
                  'Session started on:',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                subtitle: Text(
                  '${session.startTime}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: const Icon(Icons.timer, color: Colors.teal),
                title: Text(
                  'Total Duration:',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                subtitle: Text(
                  '${session.totalDuration.inSeconds} seconds',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: const Icon(Icons.star, color: Colors.amber),
                title: Text(
                  'Rating:',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                subtitle: Text(
                  '${session.rating?.toStringAsFixed(1) ?? 'Not Rated'} stars',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Phases',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: session.phases.length,
                itemBuilder: (context, index) {
                  final phase = session.phases[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: Icon(
                        phase.type == 'Hot'
                            ? Icons.whatshot
                            : Icons.ac_unit,
                        color: phase.type == 'Hot' ? Colors.red : Colors.blue,
                      ),
                      title: Text(
                        'Phase: ${phase.type}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      subtitle: Text(
                        'Duration: ${phase.duration.inSeconds} seconds',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  );
                },
              ),
            ),
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
