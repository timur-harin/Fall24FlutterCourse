import 'dart:convert';
import 'shower_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _hotKey = 'hotDuration';
  static const _coldKey = 'coldDuration';
  static const _hotTempKey = 'hotTemperature';
  static const _coldTempKey = 'coldTemperature';
  static const _historyKey = 'sessionHistory';

  Future<void> saveHotDuration(Duration hotDuration) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_hotKey, hotDuration.inSeconds);
  }

  Future<void> saveColdDuration(Duration coldDuration) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_coldKey, coldDuration.inSeconds);
  }

   Future<void> saveHotTemperature(double hotTemp) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_hotTempKey, hotTemp);
  }

  Future<void> saveColdTemperature(double coldTemp) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_coldTempKey, coldTemp);
  }

  Future<Duration> getHotDuration() async {
    final prefs = await SharedPreferences.getInstance();
    int seconds = prefs.getInt(_hotKey) ?? 30; // Default to 30 seconds
    return Duration(seconds: seconds);
  }

  Future<Duration> getColdDuration() async {
    final prefs = await SharedPreferences.getInstance();
    int seconds = prefs.getInt(_coldKey) ?? 30; // Default to 30 seconds
    return Duration(seconds: seconds);
  }

  Future<double> getHotTemperature() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_hotTempKey) ?? 40.0;
  }

  Future<double> getColdTemperature() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_coldTempKey) ?? 20.0;
  }

  Future<void> saveSessionHistory(List<ShowerSession> sessions) async {
    final prefs = await SharedPreferences.getInstance();
    final sessionsJson = jsonEncode(sessions.map((session) => session.toJson()).toList());
    await prefs.setString(_historyKey, sessionsJson);
  }

  Future<List<ShowerSession>> getSessionHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionsJson = prefs.getString(_historyKey);
    if (sessionsJson != null) {
      final sessionsList = jsonDecode(sessionsJson) as List;
      return sessionsList.map((json) => ShowerSession.fromJson(json)).toList();
    }
    return [];
  }
}
