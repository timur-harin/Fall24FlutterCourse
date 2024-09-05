import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionOverviewScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    final int sessionDuration = settings['sessionDuration']!;
    final int temperature = settings['temperature']!;
    final int sessionsAmount = settings['sessionsAmount']!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Overview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Session Duration: $sessionDuration seconds',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 20),
            Text(
              'Temperature: $temperature °C',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 20),
            Text(
              'Sessions Amount: $sessionsAmount sessions',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(
            context, '/active_session',
            arguments: {
              'sessionDuration': sessionDuration.round(),
              'temperature': temperature.round(),
              'sessionsAmount': sessionsAmount.round(),
            },);
        },
        backgroundColor: Colors.blue,
        tooltip: 'Go to session',
        label: Text(
          'Go to session',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}
