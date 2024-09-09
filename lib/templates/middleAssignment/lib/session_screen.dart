import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'session_active_screen.dart';
import 'shower_session.dart';

class SessionScreen extends ConsumerStatefulWidget {
  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends ConsumerState<SessionScreen> {
  int _counter = 5;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _navigateToActiveSession(BuildContext context, WidgetRef ref) {
    final phases = [
      TemperaturePhase(isHot: true, duration: 10),
      TemperaturePhase(isHot: false, duration: 10),
    ];

    final session = ShowerSession(
      phases: phases,
      date: DateTime.now(),
      totalDuration: phases.fold(0, (sum, phase) => sum + phase.duration),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SessionActiveScreen(session: session),
      ),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer?.cancel();
          _navigateToActiveSession(context, ref);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Contrast Shower Companion'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 140),
            const Text(
              'Be ready',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 170),
            ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(100),
              ),
              child: Text(
                '$_counter',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
