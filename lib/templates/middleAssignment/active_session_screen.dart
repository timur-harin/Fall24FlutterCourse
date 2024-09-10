import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'session_provider.dart';
import 'shower_session.dart';
import 'session_detail_screen.dart';

class ActiveSessionScreen extends ConsumerStatefulWidget {
  final ShowerSession session;
  final String firstPhase;

  ActiveSessionScreen({required this.session, required this.firstPhase});

  @override
  _ActiveSessionScreenState createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends ConsumerState<ActiveSessionScreen> {
  Timer? _timer;
  int _remainingTimeForPhase = 0;
  int _totalRemainingTime = 0;
  int _currentPhaseIndex = 0;
  bool _isPaused = false;

  List<int> _actualPhaseDurations = [];

  @override
  void initState() {
    super.initState();
    _initializePhaseOrder();
    _totalRemainingTime = widget.session.duration;
    _actualPhaseDurations = List.filled(widget.session.phases.length, 0);
    _startPhase();
  }

  void _initializePhaseOrder() {
    if (widget.firstPhase == 'cold' &&
        widget.session.phases[0].phaseType == 'hot') {
      widget.session.phases.insert(0, widget.session.phases.removeAt(1));
    }
  }

  void _startPhase() {
    setState(() {
      _remainingTimeForPhase =
          widget.session.phases[_currentPhaseIndex].duration;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!_isPaused) {
        setState(() {
          if (_totalRemainingTime > 0) {
            _totalRemainingTime--;
          }

          if (_remainingTimeForPhase > 0) {
            _remainingTimeForPhase--;
            _actualPhaseDurations[_currentPhaseIndex]++;
          }

          if (_remainingTimeForPhase == 0 && _totalRemainingTime > 0) {
            _switchPhase();
          } else if (_totalRemainingTime <= 0) {
            _endSession();
          }
        });
      }
    });
  }

  void _switchPhase() {
    if (_currentPhaseIndex < widget.session.phases.length - 1) {
      setState(() {
        _currentPhaseIndex++;
        _remainingTimeForPhase =
            widget.session.phases[_currentPhaseIndex].duration;
      });
    } else {
      _endSession();
    }
  }

  void _endSession({bool isManual = false}) {
    widget.session.remainingTime = _totalRemainingTime;

    widget.session.phases = widget.session.phases
        .where((phase) =>
            _actualPhaseDurations[widget.session.phases.indexOf(phase)] > 0)
        .toList();

    for (int i = 0; i < widget.session.phases.length; i++) {
      widget.session.phases[i] = widget.session.phases[i].copyWith(
        actualDuration: _actualPhaseDurations[i],
      );
    }

    ref.read(historyProvider.notifier).addSession(widget.session);
    _timer?.cancel();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SessionDetailScreen(
          session: widget.session,
          isManual: isManual,
          canRate: true,
        ),
      ),
    );
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentPhase = widget.session.phases[_currentPhaseIndex];

    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              color: currentPhase.phaseType == "hot"
                  ? Colors.redAccent
                  : Colors.blueAccent,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Text(
                            currentPhase.phaseType == "hot" ? 'Hot' : 'Cold',
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '$_remainingTimeForPhase',
                            style: TextStyle(
                              fontSize: 60,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            currentPhase.phaseType == "hot"
                                ? Icons.local_fire_department
                                : Icons.ac_unit,
                            size: 100,
                            color: Colors.white,
                          ),
                          SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: _togglePause,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              backgroundColor: currentPhase.phaseType == "hot"
                                  ? Colors.red.shade400
                                  : Colors.blue.shade400,
                            ),
                            child: Text(_isPaused ? 'Continue' : 'Pause'),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () => _endSession(isManual: true),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(color: Colors.white, width: 2),
                              ),
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              backgroundColor: Colors.transparent,
                            ),
                            child: Text(
                              'End Session',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Session Remaining Time: $_totalRemainingTime seconds',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
