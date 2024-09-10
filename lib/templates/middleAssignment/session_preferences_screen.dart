import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'session_provider.dart';
import 'session_overview_screen.dart';

class SessionPreferencesScreen extends ConsumerStatefulWidget {
  @override
  _SessionPreferencesScreenState createState() =>
      _SessionPreferencesScreenState();
}

class _SessionPreferencesScreenState
    extends ConsumerState<SessionPreferencesScreen> {
  int _hotPhase = 60;
  int _coldPhase = 30;
  int _cycles = 3;
  String _firstPhase = 'hot';

  int get _totalDuration => (_hotPhase + _coldPhase) * _cycles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.red.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Center(
                    child: Text(
                      'Session Preferences',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.timer, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'Total Duration: $_totalDuration seconds',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 2.0,
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.local_fire_department,
                          color: Colors.redAccent),
                      SizedBox(width: 10),
                      Text(
                        'Hot Phase Duration (seconds): $_hotPhase',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                  Slider(
                    value: _hotPhase.toDouble(),
                    min: 30,
                    max: 120,
                    divisions: 9,
                    label: _hotPhase.toString(),
                    onChanged: (value) {
                      setState(() {
                        _hotPhase = value.toInt();
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.ac_unit,
                          color: const Color.fromARGB(255, 111, 219, 248)),
                      SizedBox(width: 10),
                      Text(
                        'Cold Phase Duration (seconds): $_coldPhase',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                  Slider(
                    value: _coldPhase.toDouble(),
                    min: 15,
                    max: 60,
                    divisions: 9,
                    label: _coldPhase.toString(),
                    onChanged: (value) {
                      setState(() {
                        _coldPhase = value.toInt();
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.repeat, color: Colors.purpleAccent),
                      SizedBox(width: 10),
                      Text(
                        'Number of Cycles: $_cycles',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                  Slider(
                    value: _cycles.toDouble(),
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: _cycles.toString(),
                    onChanged: (value) {
                      setState(() {
                        _cycles = value.toInt();
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Select First Phase',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.blue.shade400, width: 2),
                    ),
                    child: DropdownButton<String>(
                      value: _firstPhase,
                      icon: Icon(Icons.arrow_drop_down,
                          color: Colors.blue.shade400),
                      iconSize: 24,
                      elevation: 16,
                      underline: SizedBox(),
                      style:
                          TextStyle(color: Colors.blue.shade400, fontSize: 18),
                      onChanged: (String? newValue) {
                        setState(() {
                          _firstPhase = newValue!;
                        });
                      },
                      items: <String>['hot', 'cold']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child:
                              Text(value[0].toUpperCase() + value.substring(1)),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 30.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        side: BorderSide(color: Colors.blue.shade400, width: 2),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        elevation: 5,
                      ),
                      onPressed: () {
                        ref.read(sessionProvider.notifier).startNewSession(
                              _hotPhase,
                              _coldPhase,
                              _cycles,
                              _firstPhase,
                            );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SessionOverviewScreen(
                              firstPhase: _firstPhase,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Start Session',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade400,
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
