import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  final String title;

  MyWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(title, key: const ValueKey('app_title')),
        ),
      ),
    );
  }
}
