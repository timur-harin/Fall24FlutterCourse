import 'package:flutter/material.dart';
import 'active_session.dart';

class SessionPreferencesScreen extends StatefulWidget {
  final void Function(Map<String, dynamic>) onStartSession;

  const SessionPreferencesScreen({required this.onStartSession, super.key});

  @override
  _SessionPreferencesScreenState createState() => _SessionPreferencesScreenState();
}

class _SessionPreferencesScreenState extends State<SessionPreferencesScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _tempIntervalController = TextEditingController();
  final TextEditingController _minTemperatureController = TextEditingController();
  final TextEditingController _maxTemperatureController = TextEditingController();

  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _durationController.addListener(_validateInputs);
    _tempIntervalController.addListener(_validateInputs);
    _minTemperatureController.addListener(_validateInputs);
    _maxTemperatureController.addListener(_validateInputs);
  }

  void _validateInputs() {
    setState(() {
      _isValid = _formKey.currentState?.validate() ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Preferences'),
        backgroundColor: const Color(0xFF009FFF),
      ),
      body: Container(
        color: const Color(0xFF00D9FF),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white, 
              borderRadius: BorderRadius.circular(20),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _durationController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Duration (minutes)',
                    ),
                    validator: (value) {
                      final number = double.tryParse(value ?? '');
                      if (number == null || number <= 0) {
                        return 'Enter a valid number greater than 0';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _tempIntervalController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Temperature Interval (seconds)',
                    ),
                    validator: (value) {
                      final number = double.tryParse(value ?? '');
                      if (number == null || number <= 0) {
                        return 'Enter a valid number greater than 0';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _minTemperatureController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Min Temperature (degrees)',
                    ),
                    validator: (value) {
                      final number = double.tryParse(value ?? '');
                      if (number == null) {
                        return 'Enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _maxTemperatureController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Max Temperature (degrees)',
                    ),
                    validator: (value) {
                      final number = double.tryParse(value ?? '');
                      if (number == null) {
                        return 'Enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _isValid
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ActiveSessionScreen(
                                  duration: int.parse(_durationController.text),
                                  temperatureInterval: int.parse(_tempIntervalController.text),
                                  minTemperature: double.parse(_minTemperatureController.text),
                                  maxTemperature: double.parse(_maxTemperatureController.text),
                                  onEndSession: widget.onStartSession,
                                ),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: const Color(0xFF1E90FF),
                    ),
                    child: const Text(
                      'Begin Session',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
