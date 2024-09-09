import 'package:fall_24_flutter_course/templates/middleAssignment/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/temperature_transition_widget.dart';
import 'confirm_dialog.dart';

class ActiveSessionScreen extends StatefulWidget {
  @override
  _activeSessionScreenState createState() => _activeSessionScreenState();
}


class _activeSessionScreenState extends State<ActiveSessionScreen> {

  int _duration = 0;
  double _max_temp = 0;
  double _min_temp = 0;
  int _phase_dur = 0;

  @override
  void initState() {
    super.initState();
    _loadParams();
  }

  Future<void> _loadParams() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _duration = prefs.getInt('duration') ?? 0;
      _max_temp = prefs.getDouble('max_temp') ?? 0;
      _min_temp = prefs.getDouble('min_temp') ?? 0;
      _phase_dur = prefs.getInt('phase_dur') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Active Session'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [       
            TemperatureTransitionWidget(minTemperature: _min_temp, maxTemperature: _max_temp, totalDuration: _duration, phaseDuration: _phase_dur,), // Custom animated widget
          ]
        )
      )
    );
  }
  
}