import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  final _textDurationController = TextEditingController();
  final _textPhaseController = TextEditingController();

  late String duration;
  late String numPhases;
  String _selectedPhase = 'Cold';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 20, 17, 30),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/',
                  );
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 15.0),
                ),
                child: const Icon(Icons.arrow_left,
                    size: 50, color: const Color.fromARGB(255, 154, 154, 154))),
            const SizedBox(
              height: 70,
            ),
            TextField(
              controller: _textPhaseController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'How many phases?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _textDurationController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'What the duration of the phase will be? (sec)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              'Pick the first phase of the session:',
              style: TextStyle(
                  color: const Color.fromARGB(255, 154, 154, 154),
                  fontSize: 25),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedPhase = 'Cold';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedPhase == 'Cold'
                        ? Colors.blue
                        : Color.fromARGB(98, 46, 128, 243),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 30.0),
                  ),
                  child: const Text('Cold',
                      style: TextStyle(color: Colors.white, fontSize: 30)),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedPhase = 'Hot';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedPhase == 'Hot'
                        ? Colors.red
                        : Color.fromARGB(99, 255, 58, 58),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 30.0),
                  ),
                  child: const Text('Hot',
                      style: TextStyle(color: Colors.white, fontSize: 30)),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                int duration = int.parse(_textDurationController.text);
                int numPhases = int.parse(_textPhaseController.text);
                Navigator.pushNamed(
                  context,
                  '/timer',
                  arguments: {
                    'numOfPhases': numPhases,
                    'duration': duration,
                    'startedWith': _selectedPhase,
                  },
                );
              },
              color: const Color.fromARGB(255, 11, 118, 81),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
              child: const Text('Begin Session',
                  style: TextStyle(fontSize: 35, color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
