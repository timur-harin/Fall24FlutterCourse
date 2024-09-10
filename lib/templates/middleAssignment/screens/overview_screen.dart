import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'active_session_screen.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/shower_session.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/session_provider.dart';

class SessionOverviewScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPreferences = ref.watch(userPreferencesProvider);
    final phases = [
      TemperaturePhase(duration: userPreferences.hotDuration, isHot: true),
      TemperaturePhase(duration: userPreferences.coldDuration, isHot: false),
    ];

    final session = ShowerSession(
      phases: phases,
      dateTime: DateTime.now(),
      totalDuration: userPreferences.hotDuration + userPreferences.coldDuration,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('session overview', style: TextStyle(fontSize: 40, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        toolbarHeight: 100,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('hot phase: ${userPreferences.hotDuration.inSeconds} seconds', style: TextStyle(color: const Color.fromARGB(255, 255, 97, 97), fontSize: 20)),
            SizedBox(height: 20),
            Text('hot temperature: ${userPreferences.hotTemperature.toDouble()} °C', style: TextStyle(color: const Color.fromARGB(255, 255, 97, 97), fontSize: 20)),
            SizedBox(height: 20),
            Text('cold phase: ${userPreferences.coldDuration.inSeconds} seconds', style: TextStyle(color: Colors.blue, fontSize: 20)),
            SizedBox(height: 20),
            Text('cold temperature: ${userPreferences.coldTemperature.toDouble()} °C', style: TextStyle(color: Colors.blue, fontSize: 20)),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                ref.read(sessionProvider.notifier).startSession(session);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActiveSessionScreen(session: session)),
                );
              },
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.lightBlueAccent)),
              child: Text('next', style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
