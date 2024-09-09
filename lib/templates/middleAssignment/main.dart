import 'package:flutter/material.dart';
import 'dart:async';
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
      title: 'Middle Assigment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

// Screen with user session history
class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionHistory = ref.watch(sessionHistoryProvider);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.red, Colors.lightBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          ),
          Positioned(
              top: 20.0,
              left: 0,
              right: 0,
              child: Center(
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewSessionScreen()),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0,
                                3),
                              ),
                            ]),
                        child: const Icon(
                          Icons.add,
                          size: 30.0,
                          color: Colors.lightBlue,
                        ),
                      )))),
          Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: sessionHistory.length,
                itemBuilder: (context, index) {
                  return ShowerSession(sessionHistory[index]);
                },
              ))
        ],
      ),
    );
  }
}

// Class for a session to contain data of a past session
class ShowerSession extends StatelessWidget {
  final String session;

  const ShowerSession(this.session);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(session, style: const TextStyle(fontSize: 17.0)),
    );
  }
}


// Screen with a choice for a new session
class NewSessionScreen extends ConsumerWidget {
  NewSessionScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> showerStrategies = [
    {
      "name": "Basic (3:1)",
      "description": "3 min hot, 1 min cold",
      "hotDuration": 180,
      "coldDuration": 60,
      "cycles": 3
    },
    {
      "name": "Quick (1:1)",
      "description": "1 min hot, 1 min cold",
      "hotDuration": 60,
      "coldDuration": 60,
      "cycles": 3
    },
    {
      "name": "Recovery (1:2)",
      "description": "30 sec hot, 1 min cold",
      "hotDuration": 30,
      "coldDuration": 60,
      "cycles": 3
    },
    {
      "name": "Energizing",
      "description": "2 min hot, 30 sec cold",
      "hotDuration": 120,
      "coldDuration": 30,
      "cycles": 3
    }
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new session'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: showerStrategies.length,
          itemBuilder: (context, index) {
            final strategy = showerStrategies[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TimerScreen(
                      sessionName: strategy['name'],
                      hotDuration: strategy['hotDuration'],
                      coldDuration: strategy['coldDuration'],
                      cycles: strategy['cycles'],
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      strategy['name']!,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      strategy['description']!,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Main timer screen for a guided session
class TimerScreen extends ConsumerStatefulWidget {
  final String sessionName;
  final int hotDuration;
  final int coldDuration;
  final int cycles;

  const TimerScreen({
    required this.sessionName,
    required this.hotDuration,
    required this.coldDuration,
    required this.cycles,
    Key? key,
  }) : super(key: key);

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends ConsumerState<TimerScreen> {
  late int currentDuration;
  late int currentCycle;
  late bool isHotPhase;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    currentCycle = 1;
    isHotPhase = true;
    currentDuration = widget.hotDuration;
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (currentDuration > 0) {
          currentDuration--;
        } else {
          if (isHotPhase) {
            isHotPhase = false;
            currentDuration = widget.coldDuration;
          } else {
            currentCycle++;
            if (currentCycle <= widget.cycles) {
              isHotPhase = true;
              currentDuration = widget.hotDuration;
            } else {
              _timer.cancel();
              showEndDialogue();
            }
          }
        }
      });
    });
  }

  void showEndDialogue() {
    String sessionResult = '${widget.sessionName} - Cycles: ${widget.cycles}';
    ref.read(sessionHistoryProvider.notifier).addSession(sessionResult);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Session completed'),
        content: const Text('All cycles done'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultsScreen(sessionName: widget.sessionName),
                ),
              );
            },
            child: const Text('See results'),
          ),
        ],
      ),
    );
  }

// Button to skip a session with saving the result
  void skipSession() {
    _timer.cancel();
    String sessionResult = '${widget.sessionName} - Skipped after cycle $currentCycle';
    ref.read(sessionHistoryProvider.notifier).addSession(sessionResult);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsScreen(sessionName: widget.sessionName),
      ),
    );
  }

  // Go back without saving and stop the timer
  void goBackWithoutSaving() {
    _timer.cancel();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 1),
        color: isHotPhase ? Colors.red : Colors.lightBlue,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isHotPhase ? 'Hot Phase' : 'Cold Phase',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                'Time Left ${currentDuration ~/ 60}:${(currentDuration % 60).toString().padLeft(2, '0')}',
                style: const TextStyle(fontSize: 50),
              ),
              const SizedBox(height: 20),
              Text(
                'Cycle $currentCycle of ${widget.cycles}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: skipSession,
                    child: const Text('Skip Session'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  ),
                  ElevatedButton(
                    onPressed: goBackWithoutSaving,
                    child: const Text('Go Back'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
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


// Screen with the session results
class ResultsScreen extends ConsumerStatefulWidget {
  final String sessionName;

  const ResultsScreen({Key? key, required this.sessionName}) : super(key: key);

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends ConsumerState<ResultsScreen> {
  double userRating = 3.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Session Complete',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'You completed the ${widget.sessionName} session',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            const Text(
              'Rate your experience:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Slider(
              value: userRating,
              min: 1.0,
              max: 5.0,
              divisions: 4,
              label: userRating.toString(),
              onChanged: (double newRating) {
                setState(() {
                  userRating = newRating;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Good job, keep it up!'),
                    content: Text('You rated the session $userRating stars'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Submit Rating'),
            ),
          ],
        ),
      ),
    );
  }
}

// Managing session history between classes
final sessionHistoryProvider = StateNotifierProvider<SessionHistoryNotifier, List<String>>((ref) {
  return SessionHistoryNotifier();
});

class SessionHistoryNotifier extends StateNotifier<List<String>> {
  SessionHistoryNotifier() : super([]) {
    _loadSessionHistory();
  }

  Future<void> _loadSessionHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Load the session history if exists or an empty list if it doesn't
    List<String>? savedHistory = prefs.getStringList('sessionHistory');
    if (savedHistory != null) {
      state = savedHistory;
    }
  }

  Future<void> addSession(String session) async {
    state = [...state, session];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('sessionHistory', state);
  }
}