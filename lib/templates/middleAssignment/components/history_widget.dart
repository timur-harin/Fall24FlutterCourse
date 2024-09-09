import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryWidget extends StatefulWidget {
  @override
  _HistoryWidgetState createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  List<String> _savedHistory = [];

  @override
  void initState() {
    super.initState();
    _loadSavedHistory();
  }

  Future<void> _loadSavedHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedHistory = prefs.getStringList('saved_history')?.reversed.toList() ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _savedHistory.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Session #${_savedHistory.length - index}: ${_savedHistory[index]}'),
        );
      },
    );
  }
}
