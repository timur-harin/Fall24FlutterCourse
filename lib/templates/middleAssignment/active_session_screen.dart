import 'package:flutter/material.dart';
import 'shower_session.dart';
import 'state_providers.dart';
import 'home_screen.dart';
import 'temperature_phase_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'dart:async';

class ActiveSessionScreen extends StatefulWidget {
  final int hotDuration;
  final int coldDuration;

  const ActiveSessionScreen({Key? key, required this.hotDuration, required this.coldDuration}) : super(key: key);

  @override
  _ActiveSessionScreenState createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends State<ActiveSessionScreen> {
  late int _currentPhaseDuration;
  late bool _isHotPhase;
  late DateTime _endTime;
  late Timer _timer;
  late int _seconds;

  @override
  void initState() {
    super.initState();
    _currentPhaseDuration = widget.hotDuration;
    _isHotPhase = true;
    _endTime = DateTime.now().add(Duration(minutes: widget.hotDuration));
    _seconds = widget.hotDuration + widget.coldDuration;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds--;
        if (_seconds == widget.coldDuration) {
          _isHotPhase = !_isHotPhase;
          _currentPhaseDuration = _isHotPhase ? widget.hotDuration : widget.coldDuration;
          _endTime = DateTime.now().add(Duration(minutes: _currentPhaseDuration));
        }
        if (_seconds == 0) {
          timer.cancel();
          final session = ShowerSession(
                  startTime: DateTime.now().subtract(Duration(minutes: _currentPhaseDuration)),
                  endTime: DateTime.now(),
                  hotDuration: widget.hotDuration,
                  coldDuration: widget.coldDuration,
                );
          final box = Hive.box<ShowerSession>('shower_history');
                box.add(session);
          Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false,
                );
        }
      });
    });

    Future.delayed(Duration(minutes: widget.hotDuration), () {
      setState(() {
        _isHotPhase = !_isHotPhase;
        _currentPhaseDuration = _isHotPhase ? widget.hotDuration : widget.coldDuration;
        _endTime = DateTime.now().add(Duration(minutes: _currentPhaseDuration));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Active Session')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(16.0), child: TemperaturePhaseIndicator(isHotPhase: _isHotPhase, hotDuration: Duration(seconds: widget.hotDuration), coldDuration: Duration(seconds: widget.coldDuration),),),
            Text('Time remaining: ${_seconds} seconds'),
            Padding(padding: EdgeInsets.all(16.0), 
            child: ElevatedButton(
              onPressed: () {
                final session = ShowerSession(
                  startTime: DateTime.now().subtract(Duration(minutes: _currentPhaseDuration)),
                  endTime: DateTime.now(),
                  hotDuration: widget.hotDuration,
                  coldDuration: widget.coldDuration,
                );

                final box = Hive.box<ShowerSession>('shower_history');
                box.add(session);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false,
                );
              },
              child: Text('End Session'),
            ),
            )
            
          ],
        ),
      ),
    );
  }
}

