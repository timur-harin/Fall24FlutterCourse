import 'dart:async';
import 'package:flutter/material.dart';
import '../models/shower_session.dart';

class AnimatedPhaseWidget extends StatefulWidget {
  final ShowerSession? currentSession;
  final bool isPaused;
  final VoidCallback? onPause;
  final VoidCallback? onResume;
  final VoidCallback onSessionEnd;
  final VoidCallback? onStopTimer;

  const AnimatedPhaseWidget({
    Key? key,
    required this.currentSession,
    required this.isPaused,
    required this.onPause,
    required this.onResume,
    required this.onSessionEnd,
    this.onStopTimer,
  }) : super(key: key);

  @override
  _AnimatedPhaseWidgetState createState() => _AnimatedPhaseWidgetState();
}

class _AnimatedPhaseWidgetState extends State<AnimatedPhaseWidget>
    with SingleTickerProviderStateMixin {
  bool isHotPhase = true;
  int currentPhaseIndex = 0;
  Duration remainingPhaseDuration = const Duration(seconds: 0);
  Duration currentPhaseDuration = const Duration(seconds: 0);
  Timer? _timer;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    if (widget.currentSession != null && widget.currentSession!.phases.isNotEmpty) {
      _animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
      )..forward(); // Start animation for phase change

      _startPhase();
    } else {
      throw UnimplementedError("Current session not found");
    }
  }

  @override
  void dispose() {
    _stopTimer();
    _animationController.dispose();
    super.dispose();
  }

  void _startPhase() {
    if (widget.currentSession == null || widget.currentSession!.phases.isEmpty) {
      return;
    }

    setState(() {
      currentPhaseDuration = widget.currentSession!.phases[currentPhaseIndex].duration;
      remainingPhaseDuration = currentPhaseDuration;
      isHotPhase = widget.currentSession!.phases[currentPhaseIndex].isHot;
    });

    _animationController.forward(from: 0.0); // Restart animation for phase change
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!widget.isPaused) {
        setState(() {
          remainingPhaseDuration -= const Duration(seconds: 1);

          if (remainingPhaseDuration.inSeconds <= 0) {
            _switchPhase();
          }
        });
      }
    });
  }

  void _switchPhase() {
    _timer?.cancel();
    setState(() {
      currentPhaseIndex++;
    });

    if (currentPhaseIndex < widget.currentSession!.phases.length) {
      _startPhase();
    } else {
      widget.onSessionEnd();
    }
  }

  @override
  void didUpdateWidget(AnimatedPhaseWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isPaused != widget.isPaused) {
      if (widget.isPaused) {
        _pauseSession();
      } else {
        _resumeSession();
      }
    }
  }

  void _pauseSession() {
    if (_timer != null && _timer!.isActive) {
      _timer?.cancel();
      widget.onPause?.call();
    }
  }

  void _resumeSession() {
    if (widget.isPaused) {
      return;
    }
    _startTimer();
    widget.onResume?.call();
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
      widget.onStopTimer?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = currentPhaseDuration.inSeconds > 0
        ? remainingPhaseDuration.inSeconds / currentPhaseDuration.inSeconds
        : 0;

    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isHotPhase
              ? [Colors.red.shade400, Colors.orange.shade200]
              : [Colors.blue.shade400, Colors.lightBlueAccent.shade200],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              value: progress,
              strokeWidth: 10,
              backgroundColor: Colors.white30,
              valueColor: AlwaysStoppedAnimation<Color>(
                isHotPhase ? Colors.orangeAccent : Colors.lightBlueAccent,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              isHotPhase ? 'Hot Phase' : 'Cold Phase',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black45,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Text(
              '${remainingPhaseDuration.inSeconds} seconds remaining',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
