import 'package:flutter/material.dart';
import 'home_screen.dart';

class SessionCompletionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Automatically navigate to home screen after 2 seconds
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
      body: Center(
        child: Text(
          'Well done!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
