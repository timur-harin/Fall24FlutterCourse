import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SessionStorage {
  Future<void> saveSession(int totalPhases, int hotDuration, int coldDuration) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList('sessionHistory') ?? [];

    Map<String, dynamic> sessionData = {
      'totalPhases': totalPhases,
      'hotDuration': hotDuration,
      'coldDuration': coldDuration,
    };

    history.add(jsonEncode(sessionData));
    await prefs.setStringList('sessionHistory', history);
  }

  Future<List<Map<String, dynamic>>> getSessionHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList('sessionHistory') ?? [];
    return history.map((session) => Map<String, dynamic>.from(jsonDecode(session))).toList();
  }
}
