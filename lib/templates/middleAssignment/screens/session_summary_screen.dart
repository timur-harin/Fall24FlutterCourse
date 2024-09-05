import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/shower_session.dart';

class SessionSummaryScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ModalRoute.of(context)!.settings.arguments as Map<String, ShowerSession>;
    final ShowerSession newSession = settings['newSession']!;

    String formatDuration(Duration duration) {
      final int minutes = duration.inMinutes;
      final int seconds = duration.inSeconds % 60;
      return '$minutes min $seconds sec';
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary of your session'),
      ),
      body: Column(
        children: [
          Text(
            'Total Duration: ${formatDuration(newSession.totalDuration)}',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Hot Duration: ${formatDuration(newSession.hotDuration)}',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Cold Duration: ${formatDuration(newSession.coldDuration)}',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ],

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/home',
            ModalRoute.withName('/home'),
          );
        },
        backgroundColor: Colors.blue,
        tooltip: 'Home',
        label: Text('Home', style: Theme.of(context).textTheme.titleSmall),
      ),
    );
  }
}
