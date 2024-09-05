import 'package:fall_24_flutter_course/templates/middleAssignment/providers/session_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/session_history_item.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionHistory = ref.watch(sessionHistoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contrast Shower Companion',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Shower Sessions',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                IconButton(
                  onPressed: () async {
                    final shouldClear = await _showConfirmationDialog(context);
                    if (shouldClear) {
                      ref.read(sessionHistoryProvider.notifier).clearHistory();
                    }
                  },
                  icon: const Icon(Icons.delete, color: Colors.black),
                )
              ],
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: sessionHistory.isEmpty
                  ? const Center(
                child: Text(
                  'No sessions recorded yet.',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey),
                ),
              )
                  : ListView.builder(
                itemCount: sessionHistory.length,
                itemBuilder: (context, index) {
                  return SessionHistoryItem(
                    session: sessionHistory[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/session_preferences');
        },
        backgroundColor: Colors.blue,
        tooltip: 'Start New Session',
        label: Text('Start new session',
            style: Theme.of(context).textTheme.titleSmall),
        icon: const Icon(Icons.add, color: Colors.white, size: 25),
      ),
    );
  }

  // A helper function to confirm clearing the history
  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear History'),
        content: const Text('Are you sure you want to clear all session history?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Clear'),
          ),
        ],
      ),
    ) ?? false;
  }
}
