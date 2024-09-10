import 'dart:async';
import 'package:flutter/material.dart';

class ActiveSessionScreen extends StatefulWidget {
  final int duration;
  final int temperatureInterval;
  final double minTemperature;
  final double maxTemperature;
  final void Function(Map<String, dynamic>) onEndSession;

  const ActiveSessionScreen({
    required this.duration,
    required this.temperatureInterval,
    required this.minTemperature,
    required this.maxTemperature,
    required this.onEndSession,
    super.key,
  });

  @override
  _ActiveSessionScreenState createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends State<ActiveSessionScreen> {
  bool _isHotPhase = true;
  late int _remainingSessionTime;
  late int _remainingPhaseTime; 
  Timer? _sessionTimer;
  Timer? _phaseTimer;

  @override
  void initState() {
    super.initState();
    _remainingSessionTime = widget.duration * 60;
    _remainingPhaseTime = widget.temperatureInterval;
    _startSessionTimer();
    _startPhaseTimer();
  }

  void _startSessionTimer() {
    _sessionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSessionTime > 0) {
          _remainingSessionTime--;
        } else {
          _sessionTimer?.cancel();
          _phaseTimer?.cancel();
          _endSession();
        }
      });
    });
  }

  void _startPhaseTimer() {
    _phaseTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingPhaseTime > 0) {
          _remainingPhaseTime--;
        } else {
          _isHotPhase = !_isHotPhase;
          _remainingPhaseTime = widget.temperatureInterval;
        }
      });
    });
  }

  void _pauseSession() {
    _sessionTimer?.cancel();
    _phaseTimer?.cancel();
  }

  void _continueSession() {
    _startSessionTimer();
    _startPhaseTimer();
  }

  void _endSession() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Session Summary'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Duration: ${widget.duration} min'),
            Text('Temp Interval: ${widget.temperatureInterval} sec'),
            Text('Min Temp: ${widget.minTemperature}°'),
            Text('Max Temp: ${widget.maxTemperature}°'),
            Text('Session Time: ${widget.duration} min'),
            const SizedBox(height: 16),
            const Text('Rate your session:'),
            RatingWidget(
              onRatingSelected: (rating) {
                Navigator.of(context).pop();
                widget.onEndSession({
                  'duration': widget.duration,
                  'tempInterval': widget.temperatureInterval,
                  'minTemperature': widget.minTemperature,
                  'maxTemperature': widget.maxTemperature,
                  'sessionTime': widget.duration,
                  'rating': rating,
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _sessionTimer?.cancel();
    _phaseTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = (_remainingSessionTime / 60).toInt();
    final seconds = _remainingSessionTime % 60;

    return Scaffold(
      backgroundColor: Color(0xFF00D9FF),
      appBar: AppBar(
        title: const Text('Active Session'),
        backgroundColor: Color(0xFF009FFF),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Session Time: ${(minutes).toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 40, color: Colors.white),
            ),
            const SizedBox(height: 32),
            SizedBox(
                width: 120,
                height: 120,
                child: CircularProgressIndicator(
                  value: _remainingPhaseTime / widget.temperatureInterval,
                  strokeWidth: 20,
                  valueColor: AlwaysStoppedAnimation<Color>(_isHotPhase ? Colors.red : Colors.blue),
                ),
              ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _pauseSession,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text(
                    'Pause',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _continueSession,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Color(0xFF1E90FF),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _endSession,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'End Session',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RatingWidget extends StatefulWidget {
  final void Function(int) onRatingSelected;

  const RatingWidget({required this.onRatingSelected, super.key});

  @override
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  int _selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(10, (index) {
            return IconButton(
              icon: Icon(
                _selectedRating > index ? Icons.star : Icons.star_border,
                color: Colors.amber,
              ),
              onPressed: () {
                setState(() {
                  _selectedRating = index + 1;
                });
              },
            );
          }),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _selectedRating > 0
              ? () {
                  widget.onRatingSelected(_selectedRating);
                }
              : null,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: Color(0xFF1E90FF),
          ),
          child: const Text(
            'Save Session',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
