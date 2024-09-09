import 'package:flutter/material.dart';

import 'templates/middleAssignment/main.dart';

void main() {
  runApp(const MiddleAssigmentApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
