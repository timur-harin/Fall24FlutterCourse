import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

class ShowerSession {
  final int numOfPhases;
  final int duration;
  final String startedWith;

  ShowerSession(this.numOfPhases, this.duration, this.startedWith) {
    // Add phases to the static list of all sessions
    buildAndAddPhases();
  }

  static final List<List<Widget>> allSessions = [];

  void buildAndAddPhases() {
    var set = {'Hot', 'Cold'};
    var first = startedWith;
    var second = set.firstWhere((phase) => phase != first);

    // Create a list of TemperaturePhase widgets for this session
    List<Widget> phases = [];

    for (int i = 0; i < numOfPhases; i++) {
      String phaseType = (i % 2 == 0) ? first : second;
      phases.add(TemperaturePhase(duration, phaseType));
    }

    // Add the list of phases to the static list of all sessions
    allSessions.add(phases);
  }
}

class TemperaturePhase extends StatelessWidget {
  final int duration;
  final String type;

  TemperaturePhase(this.duration, this.type);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color:
              type == "Hot" ? Colors.red : Colors.blue, // Use ternary operator
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text('$duration s',
            style: TextStyle(fontSize: 15, color: Colors.white)));
  }
}

class ActiveSessionScreen extends StatefulWidget {
  const ActiveSessionScreen({super.key});

  @override
  _ActiveSessionScreenState createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends State<ActiveSessionScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late String _currentPhase;
  int _remainingTime = 0;
  bool _isSessionActive = true;
  late int _duration;
  late int _numOfPhases;
  late String _startedWith;
  int _currentPhaseIndex = 0; // To track the current phase index

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Extract arguments from the navigator
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _numOfPhases = arguments['numOfPhases'] as int;
    _duration = arguments['duration'] as int;
    _startedWith = arguments['startedWith'] as String;

    // Initialize the phase and remaining time based on arguments
    _currentPhaseIndex = _startedWith == 'Hot' ? 0 : 1;
    _currentPhase = _startedWith;
    _remainingTime = _duration;

    _startTimer();
  }

  void _startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isSessionActive) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _transitionPhase();
        }
      });
    });
  }

  void _transitionPhase() {
    setState(() {
      // Increment the current phase index
      if (_currentPhaseIndex < _numOfPhases - 1) {
        _currentPhaseIndex++;
      } else {
        // If at the last phase, end the session or handle it accordingly
        _endSession();
      }

      // Determine the current phase based on the index
      _currentPhase = (_currentPhaseIndex % 2 == 0) ? 'Hot' : 'Cold';

      // Reset time for the new phase
      _remainingTime = _duration;
    });
  }

  void _pauseSession() {
    setState(() {
      _isSessionActive = false;
    });
  }

  void _endSession() {
    ShowerSession show = ShowerSession(_numOfPhases, _duration, _startedWith);
    setState(() {
      _isSessionActive = false;
      Navigator.pushNamed(context, '/');
    });
  }

  @override
  Widget build(BuildContext context) {
    Color phaseColor = _currentPhase == 'Hot' ? Colors.red : Colors.blue;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 20, 17, 30),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              color: phaseColor,
              width: 200,
              height: 200,
              alignment: Alignment.center,
              child: Text(
                '${_remainingTime}s',
                style: const TextStyle(fontSize: 48, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pauseSession,
              child: const Text('Pause'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _endSession,
              child: const Text('End Session'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
