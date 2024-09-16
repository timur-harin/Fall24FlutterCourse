import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  final String title;

  const MyWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          // TODO Add text title to test
          title: Text(title),
        ),
      ),
    );
  }
}
