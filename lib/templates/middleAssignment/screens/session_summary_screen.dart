import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/session_summary_provider.dart';
import '../widgets/rating_input.dart';

class SessionSummaryScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSummary = ref.watch(currentSessionSummaryProvider);

    if (currentSummary == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Session Summary')),
        body: Center(child: Text('No session data available')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Session Summary'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${_formatDate(currentSummary.date)}', style: Theme.of(context).textTheme.headlineSmall),
            Text('Total Time: ${currentSummary.totalTime} seconds', style: Theme.of(context).textTheme.headlineSmall),
            Text('Phases Completed: ${currentSummary.phasesCompleted}', style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 20),
            Text('Rate your experience:', style: Theme.of(context).textTheme.headlineSmall),
            RatingInput(
              initialRating: currentSummary.rating,
              onRatingChanged: (rating) {
                ref.read(currentSessionSummaryProvider.notifier).state = currentSummary.copyWith(rating: rating);
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Save and Return Home'),
              onPressed: () {
                ref.read(sessionSummaryProvider.notifier).addSession(ref.read(currentSessionSummaryProvider)!);
                ref.read(currentSessionSummaryProvider.notifier).state = null;
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
