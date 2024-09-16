import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  final String title;

  MyWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text('Hello World'),
            ),
            const SizedBox(height: 20),
            Slider(
              value: 0.5,
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),
            Checkbox(
              value: false,
              onChanged: (bool? value) {},
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Press Me'),
            ),
          ],
        ),
      ),
    );
  }
}
