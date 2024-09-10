import 'package:shared_preferences/shared_preferences.dart';

//----------------------------------------Data Persistence-----------------------------------------//

class SessionStorage {
  Future<void> saveSessionHistory(List<String> history) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('sessionHistory', history);
  }

  Future<List<String>> getSessionHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('sessionHistory') ?? [];
  }
}