import 'package:flutter/material.dart';
import 'home_screen.dart';

class SessionCompletionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (Route<dynamic> route) => false,
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Session Complete'),
      ),
      body: const Center(
        child: Text(
          'Well done!',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6750A4)),
        ),
      ),
    );
  }
}
