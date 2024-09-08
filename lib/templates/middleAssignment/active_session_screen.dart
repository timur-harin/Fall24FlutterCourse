import 'dart:async';
import 'package:fall_24_flutter_course/templates/middleAssignment/session_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'session_storage.dart';

class ActiveSessionScreen extends ConsumerStatefulWidget {
  final int hotPhaseDuration;
  final int coldPhaseDuration;
  final int totalPhases;

  ActiveSessionScreen({
    required this.hotPhaseDuration,
    required this.coldPhaseDuration,
    required this.totalPhases,
  });

  @override
  _ActiveSessionScreenState createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends ConsumerState<ActiveSessionScreen> {
  late Timer _timer;
  int _remainingTime = 0;
  int _currentPhase = 0;
  bool _isHotPhase = true;

  @override
  void initState() {
    super.initState();
    _startPhase();
  }

  void _startPhase() {
    _remainingTime = _isHotPhase ? widget.hotPhaseDuration : widget.coldPhaseDuration;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime--;
      });

      if (_remainingTime == 0) {
        _switchPhase();
      }
    });
  }

  void _switchPhase() {
    _timer.cancel();
    if (_currentPhase < widget.totalPhases - 1) {
      setState(() {
        _isHotPhase = !_isHotPhase;
        _currentPhase++;
        _startPhase();
      });
    } else {
      _endSession();
    }
  }

  void _endSession() {
    _timer.cancel();
    ref.read(sessionHistoryProvider.notifier).addSession(widget.totalPhases, widget.hotPhaseDuration, widget.coldPhaseDuration);
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
      appBar: AppBar(title: const Text('Active Session')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isHotPhase ? 'Hot Phase' : 'Cold Phase',
              style: TextStyle(
                fontSize: 24,
                color: _isHotPhase ? Colors.red : Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Time Remaining: $_remainingTime',
              style: const TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _endSession,
              child: const Text('End Session'),
            ),
          ],
        ),
      ),
    );
  }
}
