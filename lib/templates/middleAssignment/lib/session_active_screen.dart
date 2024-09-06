import 'package:flutter/material.dart';
import 'shower_session.dart';

class SessionActiveScreen extends StatefulWidget {
  final ShowerSession session;

  const SessionActiveScreen({Key? key, required this.session})
      : super(key: key);

  @override
  _SessionActiveScreenState createState() => _SessionActiveScreenState();
}

class _SessionActiveScreenState extends State<SessionActiveScreen> {
  int currentPhaseIndex = 0;
  late TemperaturePhase currentPhase;
  late int remainingTime;

  @override
  void initState() {
    super.initState();
    currentPhase = widget.session.phases[currentPhaseIndex];
    remainingTime = currentPhase.duration;
    startTimer();
  }

  void startTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
        startTimer();
      } else {
        if (currentPhaseIndex < widget.session.phases.length - 1) {
          setState(() {
            currentPhaseIndex++;
            currentPhase = widget.session.phases[currentPhaseIndex];
            remainingTime = currentPhase.duration;
          });
          startTimer();
        } else {
          // End of session
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Active Shower Session'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(currentPhase.isHot ? 'Hot Phase' : 'Cold Phase',
                style: TextStyle(fontSize: 32)),
            Text('$remainingTime seconds remaining',
                style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
