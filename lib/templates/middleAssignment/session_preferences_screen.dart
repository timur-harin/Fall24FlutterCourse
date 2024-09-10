import 'package:fall_24_flutter_course/templates/middleAssignment/session_overview_screen.dart';
import 'package:flutter/material.dart';

class SessionPreferencesScreen extends StatefulWidget {
  const SessionPreferencesScreen({super.key});

  @override
  State<SessionPreferencesScreen> createState() => _SessionPreferencesScreenState();
}

class _SessionPreferencesScreenState extends State<SessionPreferencesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _durationController = TextEditingController();
  final _hotDurationController = TextEditingController();
  final _coldDurationController = TextEditingController();

  @override
  void dispose() {
    _durationController.dispose();
    _hotDurationController.dispose();
    _coldDurationController.dispose();
    super.dispose();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Preferences'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _durationController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Total Session Duration (in minutes)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a duration';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _hotDurationController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Hot Phase Duration (in seconds)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a duration';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _coldDurationController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Cold Phase Duration (in seconds)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a duration';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    int totalDuration = int.parse(_durationController.text);
                    int hotDuration = int.parse(_hotDurationController.text);
                    int coldDuration = int.parse(_coldDurationController.text);
                    // Navigate to the Session Overview Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SessionOverviewScreen(
                          totalDuration: totalDuration,
                          hotDuration: hotDuration,
                          coldDuration: coldDuration,
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Start Session'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}