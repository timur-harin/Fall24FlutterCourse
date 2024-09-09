import 'package:flutter/material.dart';

import '../widgets/time_picker_widget.dart';

class SessionPreferencesScreen extends StatelessWidget {
  const SessionPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultSliderWidget(
              onChanged: (_) {},
              accent: Colors.blue,
              title: 'Choose overall duration',
              max: 120.0,
              initialValue: 30,
            ),
            const SizedBox(height: 16.0),
            DefaultSliderWidget(
              onChanged: (_) {},
              accent: Colors.red,
              title: 'Choose hot interval',
            ),
            const SizedBox(height: 16.0),
            DefaultSliderWidget(
              onChanged: (_) {},
              title: 'Choose cold interval',
            ),
          ],
        ),
      ),
    );
  }
}
