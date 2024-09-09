import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryNotifier extends StateNotifier<List<String>> {
  HistoryNotifier() : super([]) {
    loadSavedHistory();
  }

  Future<void> loadSavedHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('saved_history') ?? [];
    state = history.reversed.toList(); // Обновляем состояние с историей
  }

  Future<void> addSession(String session) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final updatedHistory = [session, ...state];
    await prefs.setStringList('saved_history', updatedHistory.reversed.toList());
    state = updatedHistory;
  }

  Future<void> clearHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('saved_history');
    state = [];
  }
}

final historyProvider = StateNotifierProvider<HistoryNotifier, List<String>>((ref) {
  return HistoryNotifier();
});
