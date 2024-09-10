import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/shower_session.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/session_provider.dart';
import 'summary_screen.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/storage.dart';

class ActiveSessionScreen extends ConsumerStatefulWidget {
  final ShowerSession session;

  ActiveSessionScreen({required this.session});

  @override
  _ActiveSessionScreenState createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends ConsumerState<ActiveSessionScreen> {
  Timer? _timer;
  int _remainingSeconds = 0;
  bool _isHotPhase = true;

  @override
  void initState() {
    super.initState();
    _startSession();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startSession() {
    final userPreferences = ref.read(userPreferencesProvider);

    _remainingSeconds = userPreferences.hotDuration.inSeconds;
    _isHotPhase = true;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _switchPhase();
      }
    });
  }

  void _switchPhase() {
    final userPreferences = ref.read(userPreferencesProvider);

    setState(() {
      if (_isHotPhase) {
        _remainingSeconds = userPreferences.coldDuration.inSeconds;
      } else {
        _remainingSeconds = userPreferences.hotDuration.inSeconds;
      }
      _isHotPhase = !_isHotPhase; 
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _pauseSession() {
    _timer?.cancel();
  }

  void _resumeSession() {
    _startTimer();
  }

  void _endSession() async {
    _timer?.cancel();
    final localStorageService = LocalStorageService();
    final currentHistory = await localStorageService.getSessionHistory();
    final updatedHistory = [...currentHistory, widget.session];
    await localStorageService.saveSessionHistory(updatedHistory);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SessionSummaryScreen(session: widget.session),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isHotPhase ? 'hot phase' : 'cold phase', style: TextStyle(fontSize: 40, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        toolbarHeight: 100,
      ),
      body: AnimatedContainer(
        duration: Duration(seconds: 1),
        color: _isHotPhase ? Colors.red[400] : Colors.blue[400],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_isHotPhase ? 'hot phase' : 'cold phase', style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Text(_formatTime(_remainingSeconds), style: TextStyle(fontSize: 64, color: Colors.white, fontWeight: FontWeight.bold)),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed:_pauseSession,
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.lightBlueAccent)),
                    child: Text('pause', style: TextStyle(color: Colors.white, fontSize: 20))
                  ),
                  SizedBox(width: 40),
                  ElevatedButton(
                    onPressed: _resumeSession,
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.lightBlueAccent)),
                    child: Text('resume', style: TextStyle(color: Colors.white, fontSize: 20))
                  ),
                ],
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  _timer?.cancel();
                  Navigator.pop(context);
                },
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey)),
                child: Text('end session', style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
