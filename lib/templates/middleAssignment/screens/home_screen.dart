import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/session_summary_provider.dart';
import '../widgets/session_history_list.dart';
import '../widgets/start_session_button.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionHistory = ref.watch(sessionSummaryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Contrast Shower Companion'),
      ),
      body: Column(
        children: [
          Expanded(
            child: sessionHistory.isEmpty
                ? Center(child: Text('No sessions yet. Start your first one!'))
                : SessionHistoryList(sessions: sessionHistory),
          ),
          StartSessionButton(),
        ],
      ),
    );
  }
}
