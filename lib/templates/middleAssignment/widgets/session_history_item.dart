import 'package:flutter/material.dart';
import '../models/shower_session.dart';
import 'package:intl/intl.dart';

class SessionHistoryItem extends StatelessWidget {
  final ShowerSession session;

  const SessionHistoryItem({Key? key, required this.session}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.yMMMd().format(session.date);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          'Date: $formattedDate',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        subtitle: Text(
          'Duration: ${session.totalDuration.inSeconds} seconds\n'
              'Phases: ${session.phases.length} (Hot: ${session.hotDuration.inSeconds} seconds, Cold: ${session.coldDuration.inSeconds} seconds)',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
    );
  }
}
