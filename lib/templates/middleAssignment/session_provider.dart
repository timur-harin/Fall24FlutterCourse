import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shower_session.dart';
import 'storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

final sessionProvider = StateNotifierProvider<SessionNotifier, ShowerSession?>((ref) {
  return SessionNotifier();
});

final userPreferencesProvider = StateNotifierProvider<UserPreferencesNotifier, UserPreferences>((ref) {
  final localStorageService = LocalStorageService();
  return UserPreferencesNotifier(localStorageService);
});

final historyProvider = StateNotifierProvider<HistoryNotifier, List<ShowerSession>>((ref) {
  return HistoryNotifier()..loadHistory();
});

class SessionNotifier extends StateNotifier<ShowerSession?> {
  SessionNotifier() : super(null);

  void startSession(ShowerSession session) {
    state = session;
  }

  void endSession() {
    state = null;
  }
}

class UserPreferencesNotifier extends StateNotifier<UserPreferences> {
  final LocalStorageService _storageService;

  UserPreferencesNotifier(this._storageService) : super(UserPreferences()) {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final hotDuration = await _storageService.getHotDuration();
    final coldDuration = await _storageService.getColdDuration();
    final hotTemperature = await _storageService.getHotTemperature();
    final coldTemperature = await _storageService.getColdTemperature();
    state = UserPreferences(hotDuration: hotDuration, coldDuration: coldDuration, hotTemperature: hotTemperature, coldTemperature: coldTemperature);
  }

  Future<void> updatePreferences(Duration hotDuration, Duration coldDuration, double hotTemperature, double coldTemperature) async {
    state = UserPreferences(hotDuration: hotDuration, coldDuration: coldDuration, hotTemperature: hotTemperature, coldTemperature: coldTemperature);
    await _storageService.saveHotDuration(hotDuration);
    await _storageService.saveColdDuration(coldDuration);
    await _storageService.saveHotTemperature(hotTemperature);
    await _storageService.saveColdTemperature(coldTemperature);
  }
}

class HistoryNotifier extends StateNotifier<List<ShowerSession>> {
  HistoryNotifier() : super([]);

  Future<void> loadHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final historyData = prefs.getString('shower_history');
    if (historyData != null) {
      List<dynamic> jsonList = jsonDecode(historyData);
      state = jsonList.map((json) => ShowerSession.fromJson(json)).toList();
    }
  }

  Future<void> addSession(ShowerSession session) async {
    state = [...state, session];
    await saveHistory();
  }

  Future<void> saveHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList = state.map((session) => jsonEncode(session)).toList();
    await prefs.setString('shower_history', jsonEncode(jsonList));
  }
}