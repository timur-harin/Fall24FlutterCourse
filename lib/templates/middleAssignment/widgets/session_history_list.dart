import 'package:flutter/material.dart';
import '../models/session_summary.dart';

class SessionHistoryList extends StatelessWidget {
  final List<SessionSummary> sessions;

  const SessionHistoryList({Key? key, required this.sessions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sessions.length,
      itemBuilder: (context, index) {
        final session = sessions[index];
        return ListTile(
          title: Text('Session on ${_formatDate(session.date)}'),
          subtitle: Text('Duration: ${session.totalTime} seconds'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, color: Colors.amber),
              Text(session.rating.toStringAsFixed(1)),
            ],
          ),
          onTap: () {
          },
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
