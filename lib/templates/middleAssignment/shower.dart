import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'notifier.dart';
import 'temperature.dart';

class MyHomePage extends ConsumerWidget{
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext  context, WidgetRef ref){
    final sessionHistory = ref.watch(showerHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contrast Shower Companion'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: sessionHistory.isEmpty
                ? const Center(child: Text('No session history available.'))
                : ListView.builder(
                    itemCount: sessionHistory.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Session ${index + 1}'),
                        subtitle: Text(sessionHistory[index]),
                      );
                    },
                  ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewSessionScreen()),
              );
            },
            child: const Text('Start New Session'),
          ),
        ],
      ),
    );
  }
}

//-------------------------------------------New Session-------------------------------------------//

class NewSessionScreen extends StatefulWidget{
  const NewSessionScreen({super.key});

  @override 
  _NewSessionScreenState createState() => _NewSessionScreenState();
}

class _NewSessionScreenState extends State<NewSessionScreen>{
  int _hotPhaseDuration = 180;
  int _coldPhaseDuration = 60;
  int _numberOfPhases = 3;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("New Shower Session"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Hot Phase Duration: $_hotPhaseDuration seconds"),
            Slider(
              value: _hotPhaseDuration.toDouble(),
              min: 60,
              max: 240,
              divisions: 10,
              label: _hotPhaseDuration.toString(),
              onChanged: (value){
                setState(() {
                  _hotPhaseDuration = value.toInt();
                });
              },
            ),
            Text("Cold Phase Duration: $_coldPhaseDuration"),
            Slider(
              value: _coldPhaseDuration.toDouble(),
              min: 30,
              max: 120,
              divisions: 10,
              label: _coldPhaseDuration.toString(),
              onChanged: (value){
                setState(() {
                  _coldPhaseDuration = value.toInt();
                });
              },
            ),
            Text("Number of Phases: $_numberOfPhases"),
            Slider(
              value: _numberOfPhases.toDouble(),
              min: 3,
              max: 10,
              divisions: 4,
              label: _numberOfPhases.toString(),
              onChanged: (value){
                setState(() {
                  _numberOfPhases = value.toInt();
                });
              },
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActiveSessionScreen(
                      hotPhaseDuration: _hotPhaseDuration,
                      coldPhaseDuration: _coldPhaseDuration,
                      numberOfPhases: _numberOfPhases,
                    ),
                  ),
                );
              }, 
              child: const Text("Start Session")
            )
          ],
        ),
      ),
    );
  }
}

//------------------------------------------Active Session-----------------------------------------//

class ActiveSessionScreen extends StatefulWidget {
  final int hotPhaseDuration;
  final int coldPhaseDuration;
  final int numberOfPhases;

  const ActiveSessionScreen({
    Key? key,
    required this.hotPhaseDuration,
    required this.coldPhaseDuration,
    required this.numberOfPhases,
  }) : super(key: key);

  @override
  _ActiveSessionScreenState createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends State<ActiveSessionScreen> {
  int currentPhase = 1;
  bool isHotPhase = true;
  late int remainingTime;

  @override
  void initState() {
    super.initState();
    remainingTime = widget.hotPhaseDuration; // Start with hot phase
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
        _startTimer(); // Recursive to keep the timer running
      } else {
        _switchPhase();
      }
    });
  }

  void _switchPhase() {
    if (currentPhase < widget.numberOfPhases * 2) {
      setState(() {
        isHotPhase = !isHotPhase;
        currentPhase++;
        remainingTime = isHotPhase
            ? widget.hotPhaseDuration
            : widget.coldPhaseDuration;
      });
      _startTimer();
    } else {
      // Session finished, navigate back or show a summary
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Session'),
      ),
      body: Center(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TemperatureTransitionWidget(isHotPhase: isHotPhase),
            Text(
              isHotPhase ? 'Hot Phase' : 'Cold Phase',
              style: TextStyle(
                fontSize: 24,
                color: isHotPhase ? Colors.red : Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '$remainingTime seconds remaining',
              style: const TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Option to manually stop the session
                Navigator.pop(context);
              },
              child: const Text('End Session Early'),
            ),
          ],
        ),
      ),
    );
  }
}



