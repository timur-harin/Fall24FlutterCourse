import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/components/history_widget.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/screens/new_session_screen.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/components/history_notifier.dart';

class MainScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyNotifier = ref.read(historyProvider.notifier);
    historyNotifier.loadSavedHistory();
    List<String> history = ref.watch(historyProvider).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Contrast Shower Companion'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              historyNotifier.clearHistory(); // Очищаем историю при нажатии
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewSessionScreen()),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 112, 22, 22),
              shape: CircleBorder(),
              padding: EdgeInsets.all(40),
              minimumSize: Size(150, 150),
            ),
            child: Text(
              'Start New Session',
              style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
          SizedBox(height: 50),
          Text("Session history:"),
          SizedBox(height: 30),
          Expanded(
            child: HistoryWidget(history: history,)
          ),
        ],
      ),
    );
  }
}
