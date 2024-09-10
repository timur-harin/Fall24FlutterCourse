import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shower_session.dart';
import 'temperature_phase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

final sessionProvider =
    StateNotifierProvider<SessionNotifier, ShowerSession>((ref) {
  return SessionNotifier();
});

final historyProvider =
    StateNotifierProvider<HistoryNotifier, List<ShowerSession>>((ref) {
  return HistoryNotifier();
});

class HistoryNotifier extends StateNotifier<List<ShowerSession>> {
  HistoryNotifier() : super([]) {
    _loadSessions();
  }

  Future<void> _loadSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final String? sessionData = prefs.getString('sessionHistory');
    if (sessionData != null) {
      final List<dynamic> decodedData = jsonDecode(sessionData);
      state = decodedData.map((item) => ShowerSession.fromJson(item)).toList();
    }
  }

  Future<void> addSession(ShowerSession session) async {
    state = [...state, session];
    await _saveSessions();
    final prefs = await SharedPreferences.getInstance();
    final String encodedData =
        jsonEncode(state.map((e) => e.toJson()).toList());
    await prefs.setString('sessionHistory', encodedData);
  }

  Future<void> updateSession(ShowerSession updatedSession) async {
    state = [
      for (final session in state)
        if (session.startTime == updatedSession.startTime)
          updatedSession
        else
          session
    ];
    await _saveSessions();
  }

  Future<void> _saveSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData =
        jsonEncode(state.map((e) => e.toJson()).toList());
    await prefs.setString('sessionHistory', encodedData);
  }
}

class SessionNotifier extends StateNotifier<ShowerSession> {
  SessionNotifier()
      : super(ShowerSession(
          phases: [],
          startTime: DateTime.now(),
          duration: 300,
          remainingTime: 300,
        ));

  void startNewSession(
      int hotPhase, int coldPhase, int cycles, String firstPhase) {
    List<TemperaturePhase> phases = [];
    String currentPhaseType = firstPhase;

    for (int i = 0; i < cycles; i++) {
      if (currentPhaseType == 'hot') {
        phases.add(TemperaturePhase(phaseType: 'hot', duration: hotPhase));
      } else {
        phases.add(TemperaturePhase(phaseType: 'cold', duration: coldPhase));
      }

      currentPhaseType = currentPhaseType == 'hot' ? 'cold' : 'hot';
      if (currentPhaseType == 'hot') {
        phases.add(TemperaturePhase(phaseType: 'hot', duration: hotPhase));
      } else {
        phases.add(TemperaturePhase(phaseType: 'cold', duration: coldPhase));
      }
      currentPhaseType = currentPhaseType == 'hot' ? 'cold' : 'hot';
    }

    state = ShowerSession(
      phases: phases,
      startTime: DateTime.now(),
      duration: (hotPhase + coldPhase) * cycles,
      remainingTime: (hotPhase + coldPhase) * cycles,
    );
  }

  void tick() {
    if (state.remainingTime > 0) {
      state = state.copyWith(remainingTime: state.remainingTime - 1);
    } else {
      _switchPhase();
    }
  }

  void _switchPhase() {
    state = state.copyWith(isHotPhase: !state.isHotPhase);
  }
}
