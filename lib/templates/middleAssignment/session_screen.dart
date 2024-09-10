import 'dart:async';

import 'package:fall_24_flutter_course/templates/middleAssignment/timer_widget.dart';
import 'package:flutter/material.dart';
import 'phase_transition_animation.dart';
import 'package:audioplayers/audioplayers.dart';
import 'session_summary_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
  late AudioPlayer _audioPlayer;
  late AudioCache _audioCache;
  int _phasesCompleted = 0; // Track the number of phases completed

  @override
  void initState() {
    super.initState();
    _remainingTime = Duration(minutes: widget.totalDuration);
    _audioPlayer = AudioPlayer();
    _audioCache = AudioCache();
    _phasesCompleted = 0; // Initialize phases completed to 0
  }


  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _startSession() {
    setState(() {
      _isSessionActive = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_remainingTime > Duration.zero) {
            _remainingTime -= const Duration(seconds: 1);
            var switchCheck = _remainingTime.inSeconds % (widget.hotDuration + widget.coldDuration) + 1;
            if((switchCheck == widget.hotDuration) || (switchCheck == widget.hotDuration + widget.coldDuration)){
              _switchPhase();
            }
          } else {
            _stopSession();
          }
        });
      });
    });
  }

  void _pauseSession() {
    _timer?.cancel();
    setState(() {
      _isSessionActive = false;
    });
  }

  void _resumeSession() {
    _startSession();
  }

  void _stopSession() {
    _timer?.cancel();
    setState(() {
      _isSessionActive = false;
      _remainingTime = Duration(minutes: widget.totalDuration);
    });

    _saveSessionHistory(
      widget.totalDuration, widget.hotDuration, widget.coldDuration, _phasesCompleted
    );

    // Navigate to the summary screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SessionSummaryScreen(
          totalDuration: widget.totalDuration,
          hotDuration: widget.hotDuration,
          coldDuration: widget.coldDuration,
          phasesCompleted: _phasesCompleted,
        ),
      ),
    );
  }

  Future<void> _saveSessionHistory(
    int totalDuration, int hotDuration, int coldDuration, int phasesCompleted) async {
    String hist = '$totalDuration,$hotDuration,$coldDuration,$phasesCompleted';
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList('sessionHistory') ?? [];
    history.add(hist);
    await prefs.setStringList('sessionHistory', history);

  }

void _switchPhase() {
    _phasesCompleted++;
    // Play sound notification
    _audioCache.load('assets/sounds/switch.wav');
    _audioPlayer.play(DeviceFileSource('assets/sounds/switch.wav'));
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
            PhaseTransitionAnimation(
              isHotPhase: _remainingTime.inSeconds % 
                  (widget.hotDuration + widget.coldDuration) < widget.hotDuration,
              duration: const Duration(milliseconds: 500), // Duration of the animation
            ),
            const SizedBox(height: 32),
            if (_isSessionActive)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _pauseSession,
                    child: const Text('Pause'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _stopSession,
                    child: const Text('Stop'),
                  ),
                ],
              )
            else if (!_isSessionActive && _remainingTime == Duration(minutes: widget.totalDuration))
              ElevatedButton(
                onPressed: _startSession,
                child: const Text('Start'),
              )
            else if (!_isSessionActive && _remainingTime > Duration.zero)
              ElevatedButton(
                onPressed: _resumeSession,
                child: const Text('Resume'),
              ),
          ],
        ),
      ),
    );
  }
}