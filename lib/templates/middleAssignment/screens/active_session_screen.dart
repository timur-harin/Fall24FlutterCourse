import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/shower_session.dart';
import '../providers/session_history_provider.dart';

class ActiveSessionScreen extends ConsumerStatefulWidget {
  @override
  _ActiveSessionScreenState createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends ConsumerState<ActiveSessionScreen> {
  late Timer _timer;
  int _timeRemaining = 0;
  bool _isHotPhase = true;
  bool _isPaused = false;
  List<TemperaturePhase> _phases = [];
  int _completedSessions = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startSession();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startSession() {
    final settings = ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    final int sessionDuration = settings['sessionDuration']!;
    _timeRemaining = sessionDuration;
    _isHotPhase = true;
    _timer = Timer.periodic(Duration(seconds: 1), _updateTimer);
  }

  void _updateTimer(Timer timer) {
    if (!_isPaused) {
      setState(() {
        if (_timeRemaining > 0) {
          _timeRemaining--;
        } else {
          _recordPhase();
          _togglePhase();
          _checkIfSessionComplete();
        }
      });
    }
  }

  void _recordPhase() {
    final settings = ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    final int sessionDuration = settings['sessionDuration']!;
    _phases.add(
      TemperaturePhase(
        duration: Duration(seconds: sessionDuration - _timeRemaining),
        isHot: _isHotPhase,
      ),
    );
  }

  void _togglePhase() {
    final settings = ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    final int sessionDuration = settings['sessionDuration']!;
    setState(() {
      _isHotPhase = !_isHotPhase;
      _timeRemaining = sessionDuration;
    });
  }

  void _checkIfSessionComplete() {
    final settings =
    ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    final int sessionsAmount = settings['sessionsAmount']!; // Total session count

    _completedSessions++;

    if (_completedSessions >= sessionsAmount * 2) {
      _endSession();
    }
  }

  Future<void> _endSession() async {
    _timer.cancel();
    _recordPhase(); // Record the final phase

    final settings = ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    final sessionDuration = settings['sessionDuration']!;
    final totalDuration = sessionDuration * _phases.length;
    final hotDuration = _phases
        .where((phase) => phase.isHot)
        .fold<int>(0, (prev, phase) => prev + phase.duration.inSeconds);
    final coldDuration = totalDuration - hotDuration;

    final newSession = ShowerSession(
      date: DateTime.now(),
      totalDuration: Duration(seconds: totalDuration),
      hotDuration: Duration(seconds: hotDuration),
      coldDuration: Duration(seconds: coldDuration),
      phases: _phases,
    );

    await ref.read(sessionHistoryProvider.notifier).addSession(newSession);

    Navigator.pushNamed(
      context,
      '/session_summary',
      arguments: {
        'newSession': newSession
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Session'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Timer Display
            Text(
              'Time Remaining: $_timeRemaining s',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: _isHotPhase ? Colors.red : Colors.blue,
              ),
            ),
            const SizedBox(height: 40),

            // Central Circle Indicator
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _isHotPhase ? Colors.red : Colors.blue,
              ),
            ),
            const SizedBox(height: 40),
            // Pause/Resume Button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: _isHotPhase ? Colors.red : Colors.blue,
                textStyle: const TextStyle(
                    color: Colors.white
                ),
              ),
              onPressed: () {
                setState(() {
                  _isPaused = !_isPaused;
                });
              },
              icon: Icon(
                  _isPaused ? Icons.play_arrow : Icons.pause,
                  color: Colors.white
              ),
              label: Text(
                _isPaused ? 'Resume' : 'Pause',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _endSession,
        backgroundColor: Colors.blue,
        tooltip: 'Go to summary',
        label: Text(
          'End session',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
