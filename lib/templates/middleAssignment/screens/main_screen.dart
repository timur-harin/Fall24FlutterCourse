import 'package:fall_24_flutter_course/templates/middleAssignment/components/history_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MainScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contrast Shower Companion'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/newSession'),
              child: Text('Start New Session'),
            ),
          SizedBox(height: 50),
          Text("Session history:"),
          SizedBox(height: 30),
          Expanded(
              child: HistoryWidget(), // Вставляем виджет для отображения данных
            ),
          
        ],
      ),
    );
  }
}