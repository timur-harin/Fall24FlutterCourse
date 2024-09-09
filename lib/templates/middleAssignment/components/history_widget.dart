import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/components/history_notifier.dart';

class HistoryWidget extends ConsumerWidget {
  HistoryWidget({required this.history});
  List<String> history;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    if (history.isEmpty) {
      return Center(
        child: Text('No sessions yet'),
      );
    }

    return ListView.builder(
      itemCount: history.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Session #${history.length - index}: ${history[index]}'),
        );
      },
    );
  }
}
