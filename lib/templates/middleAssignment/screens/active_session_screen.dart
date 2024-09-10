import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mid_assignment/models/shower_session.dart';
import 'package:mid_assignment/models/user_preferences.dart';

class ActiveSessionScreen extends StatefulWidget {
  final UserPreferences preferences;

  ActiveSessionScreen({required this.preferences});

  @override
  _ActiveSessionScreenState createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends State<ActiveSessionScreen> {
  late ShowerSession session;
  StreamSubscription? _timerSubscription;
  int _currentPhaseTimeLeft = 0;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    session = ShowerSession(phases: [], totalTime: 0, completedPhases: 0);
    _startNextPhase();
  }

  void _startNextPhase() {
    if (widget.preferences.phases.length > session.completedPhases) {
      _currentPhaseTimeLeft =
          widget.preferences.phases[session.completedPhases].duration * 60;
      _timerSubscription = Stream.periodic(Duration(seconds: 1)).listen((_) {
        if (_currentPhaseTimeLeft > 0) {
          setState(() {
            _currentPhaseTimeLeft--;
          });
        } else {
          _timerSubscription?.cancel();
          session.phases
              .add(widget.preferences.phases[session.completedPhases]);
          session.completedPhases++;
          session.totalTime += session.phases.last.duration;
          _startNextPhase();
        }
      });
    } else {
      Navigator.pushNamed(context, '/session-summary', arguments: session);
    }
  }

  @override
  Widget build(BuildContext context) {
    int minutes = _currentPhaseTimeLeft ~/ 60;
    int seconds = _currentPhaseTimeLeft % 60;
    return Scaffold(
      appBar: AppBar(
        title: Text('Active Session'),
      ),
      body: Container(
        color: widget.preferences.phases[session.completedPhases].phaseType ==
                'Hot'
            ? Colors.red
            : Colors.blue,
        child: Center(
          child: Text(
            'Time left: ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
            style: TextStyle(fontSize: 48),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              if (_isPaused) {
                _timerSubscription?.resume();
              } else {
                _timerSubscription?.pause();
              }
              setState(() {
                _isPaused = !_isPaused;
              });
            },
            child: Icon(_isPaused ? Icons.play_arrow : Icons.pause),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              _timerSubscription?.cancel();
              Navigator.pushNamed(context, '/session-summary',
                  arguments: session);
            },
            child: Icon(Icons.stop),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timerSubscription?.cancel();
    super.dispose();
  }
}
