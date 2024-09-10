import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _sessionHistory = 'sessionHistory';

  Future<void> saveHistory(String hist) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList('sessionHistory') ?? [];
    history.add(hist);
    await prefs.setStringList(_sessionHistory, history);
  }

  Future<List<String>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('sessionHistory') ?? [];
  }
}