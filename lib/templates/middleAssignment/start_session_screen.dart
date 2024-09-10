import 'package:flutter/material.dart';
import 'session_overview_screen.dart';

class StartSessionScreen extends StatefulWidget {
  @override
  _StartSessionScreenState createState() => _StartSessionScreenState();
}

class _StartSessionScreenState extends State<StartSessionScreen> {
  final _hotDurationController = TextEditingController();
  final _coldDurationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Start New Session')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _hotDurationController,
              decoration: InputDecoration(labelText: 'Hot Duration (sec)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _coldDurationController,
              decoration: InputDecoration(labelText: 'Cold Duration (sec)'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SessionOverviewScreen(
                      hotDuration: int.parse(_hotDurationController.text),
                      coldDuration: int.parse(_coldDurationController.text),
                    ),
                  ),
                );
              },
              child: Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
