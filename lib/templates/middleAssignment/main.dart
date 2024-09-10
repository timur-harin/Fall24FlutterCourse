import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mid_assignment/screens/home_screen.dart';
import 'package:mid_assignment/screens/session_preferences_screen.dart';
import 'package:mid_assignment/screens/session_summary_screen.dart';

void main() {
  runApp(ProviderScope(child: MiddleAssigmentApp()));
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Middle Assigment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        '/new-session': (context) => SessionPreferencesScreen(),
        '/session-summary': (context) => SessionSummaryScreen(),
      },
    );
  }
}
