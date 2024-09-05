import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/shower_session.dart';

const String sessionHistoryKey = 'sessionHistory';

final sessionHistoryProvider = StateNotifierProvider<SessionHistoryNotifier, List<ShowerSession>>((ref) {
  return SessionHistoryNotifier();
});

class SessionHistoryNotifier extends StateNotifier<List<ShowerSession>> {
  SessionHistoryNotifier() : super([]) {
    _loadSessionHistory();
  }

  Future<void> _loadSessionHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? sessionHistoryJson = prefs.getString(sessionHistoryKey);
    if (sessionHistoryJson != null) {
      final List<dynamic> sessionList = jsonDecode(sessionHistoryJson);
      state = sessionList.map((json) => ShowerSession.fromJson(json)).toList();
    }
  }

  Future<void> addSession(ShowerSession session) async {
    state = [...state, session];
    await _saveSessionHistory();
  }

  Future<void> _saveSessionHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String sessionHistoryJson = jsonEncode(state.map((session) => session.toJson()).toList());
    await prefs.setString(sessionHistoryKey, sessionHistoryJson);
  }

  Future<void> clearHistory() async {
    state = [];
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(sessionHistoryKey);
  }
}
