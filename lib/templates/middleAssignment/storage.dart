import 'package:shared_preferences/shared_preferences.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/showersession.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

class LocalStorageService {
  //static const _preferencesKey = 'globalPreferences';
  static const _historyKey = 'showerHistory';
  static const _sessionSettingsKey = 'sessionPreferences';

  Future<void> saveSessions(List<ShowerSession> sessions) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_historyKey, sessions.map((s) => jsonEncode(s.toJson())).toList());
  }

  Future<List<ShowerSession>> getSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final stringList = prefs.getStringList(_historyKey) ?? [];
    return stringList.map((s) => ShowerSession.fromJson(jsonDecode(s))).toList(); 
  }

  Future<void> saveSettings(ShowerSession s) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sessionSettingsKey, jsonEncode(s.toJson()));
  }

  Future<ShowerSession> getSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_sessionSettingsKey);
    if(s != null) {
      return ShowerSession.fromJson(jsonDecode(s));
    } else {
      return emptyShowerSession;

    }
  }
}
