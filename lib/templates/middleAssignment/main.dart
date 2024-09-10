import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/homepage.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/settingspage.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/showerpage.dart';

void main() {
  runApp(const ProviderScope(child: MiddleAssigmentApp()));
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
        '/': (context) => HomePage(),
        '/settings': (context) => SettingsPage(),
        '/shower': (context) => ShowerPage(),
      },
    );
  }
}