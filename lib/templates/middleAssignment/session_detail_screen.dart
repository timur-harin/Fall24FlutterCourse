import 'package:flutter/material.dart';
import 'shower_session.dart';

class SessionDetailScreen extends StatelessWidget {
  final ShowerSession session;

  const SessionDetailScreen({Key? key, required this.session}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Session Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Start Time: ${session.startTime}'),
            Text('End Time: ${session.endTime}'),
            Text('Hot Duration: ${session.hotDuration} min'),
            Text('Cold Duration: ${session.coldDuration} min'),
          ],
        ),
      ),
    );
  }
}
