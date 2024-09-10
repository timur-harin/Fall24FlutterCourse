import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'state_providers.dart';
import 'start_session_screen.dart';
import 'session_detail_screen.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(showerHistoryProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Shower History')),
      body: ListView(
        children: [
          ...history.map((session) => ListTile(
                title: Text('Session on ${session.startTime}'),
                subtitle: Text('Hot for ${session.hotDuration} sec, Cold for ${session.coldDuration} sec'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SessionDetailScreen(session: session))),
              )),
          Center(
            child: ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => StartSessionScreen())),
              child: Text('Start New Session'),
            ),
          ),
        ],
      ),
    );
  }
}
