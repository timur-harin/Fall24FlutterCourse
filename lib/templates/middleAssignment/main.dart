import 'package:fall_24_flutter_course/templates/middleAssignment/screens/active_session_screen.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/screens/home_screen.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/screens/session_overview_screen.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/screens/session_preferences_screen.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/screens/session_summary_screen.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MiddleAssigmentApp()));
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Middle Assigment',
      theme: appTheme,
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(),
        '/session_preferences': (context) => SessionPreferencesScreen(),
        '/session_overview': (context) => SessionOverviewScreen(),
        '/active_session': (context) => ActiveSessionScreen(),
        '/session_summary': (context) => SessionSummaryScreen(),
      },
    );
  }
}
