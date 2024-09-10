import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

import 'settingsPage.dart';
import 'timer.dart';

List<ShowerSession> showerSessions = [];

void main() {
  ShowerSession s1 = ShowerSession(3, 20, 'Hot');
  ShowerSession s2 = ShowerSession(4, 30, 'Cold');
  runApp(const MiddleAssigmentApp());
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Middle Assigment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Home Page'),
        '/start': (context) => const SettingsPage(),
        '/timer': (context) => const ActiveSessionScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      backgroundColor: Color.fromARGB(255, 20, 17, 30),
      // Sets the content to the
      // center of the application page
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () async {
              final result = await Navigator.pushNamed(context, '/start');

              if (result != null && result is ShowerSession) {
                setState(() {
                  // Build and add the phase widgets to the allSessions list
                  result.buildAndAddPhases(); // Add phase widgets to the list
                });
              }
            },
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(230, 230)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 11, 118, 81),
              ),
            ),
            child: const Text(
              "Start a\nNew\nSession",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 35,
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(height: 20), // Spacing between elements
          // Custom widget with text and squares
          PrevShowerWidget(),
        ],
      )),
    );
  }
}

class PrevShowerWidget extends StatefulWidget {
  @override
  _PrevShowerWidgetState createState() => _PrevShowerWidgetState();
}

class _PrevShowerWidgetState extends State<PrevShowerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 98, 103, 147),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: ShowerSession.allSessions.map((phases) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: phases,
          );
        }).toList(),
      ),
    );
  }
}

class UserPreferences {}
