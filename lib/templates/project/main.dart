import 'package:flutter/material.dart';

void main() {
  runApp(const ProjectApp());
}

class ProjectApp extends StatelessWidget {
  const ProjectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // TODO - complete assignment
      home: null,
    );
  }
}
