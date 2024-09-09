import 'package:flutter/material.dart';

import 'presentation/home/screens/home_screen.dart';

void main() {
  runApp(const MiddleAssigmentApp());
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        title: 'Middle Assigment',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}