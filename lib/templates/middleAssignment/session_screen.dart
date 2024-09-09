import 'dart:async';

import 'package:fall_24_flutter_course/templates/middleAssignment/timer_widget.dart';
import 'package:flutter/material.dart';

class SessionScreen extends StatefulWidget {
  final int totalDuration;
  final int hotDuration;
  final int coldDuration;

  const SessionScreen({
    super.key,
    required this.totalDuration,
    required this.hotDuration,
    required this.coldDuration,
  });

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  Timer? _timer;
  bool _isSessionActive = false; // Flag to track active session
  Duration _remainingTime = Duration.zero; // Initial time is zero

  @override
  void initState() {
    super.initState();
    _remainingTime = Duration(minutes: widget.totalDuration);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startSession() {
    setState(() {
      _isSessionActive = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_remainingTime > Duration.zero) {
            _remainingTime -= const Duration(seconds: 1);
          } else {
            _stopSession();
          }
        });
      });
    });
  }

  void _stopSession() {
    _timer?.cancel();
    setState(() {
      _isSessionActive = false;
      _remainingTime = Duration.zero; 
    });
  }

  void _switchPhase() {
    // Switch between hot and cold phases
    setState(() {
      _remainingTime = _remainingTime > Duration.zero
          ? _remainingTime - Duration(seconds: (_remainingTime.inSeconds % 
              (widget.hotDuration + widget.coldDuration) == 0 
              ? widget.hotDuration 
              : widget.coldDuration))
          : Duration.zero; // Ensure time doesn't go negative
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimerWidget(
              totalDuration: widget.totalDuration,
              hotDuration: widget.hotDuration,
              coldDuration: widget.coldDuration,
              remainingTime: _remainingTime,
              isHotPhase: _remainingTime.inSeconds % 
                  (widget.hotDuration + widget.coldDuration) < widget.hotDuration, 
            ),
            const SizedBox(height: 32),
            if (!_isSessionActive)
              ElevatedButton(
                onPressed: _startSession,
                child: const Text('Start Session'),
              )
            else
              ElevatedButton(
                onPressed: _stopSession,
                child: const Text('Stop Session'),
              ),
          ],
        ),
      ),
    );
  }
}