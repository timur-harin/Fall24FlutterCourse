import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/storage.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/showersession.dart';
import 'package:flutter/material.dart';
import 'dart:async';

final historyProvider =
    StateNotifierProvider<HistoryNotifier, List<ShowerSession>>((ref) {
  final localStorageService = ref.watch(localStorageServiceProvider);
  return HistoryNotifier(localStorageService);
});

class HistoryNotifier extends StateNotifier<List<ShowerSession>> {
  final LocalStorageService _localStorageService;

  HistoryNotifier(this._localStorageService) : super([]) {
    _loadHistory();
  }

  void _loadHistory() async {
    state = await _localStorageService.getSessions();
  }

  void appendSession(ShowerSession s) async {
    state = [...state, s];
    await _localStorageService.saveSessions(state);
  }

  void reset() async {
    state = [];
    await _localStorageService.saveSessions(state);
  }
}

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, ShowerSession>((ref) {
  final localStorageService = ref.watch(localStorageServiceProvider);
  return SettingsNotifier(localStorageService);
});

class SettingsNotifier extends StateNotifier<ShowerSession> {
  final LocalStorageService _localStorageService;

  SettingsNotifier(this._localStorageService) : super(emptyShowerSession) {
    _loadSettings();
  }

  void _loadSettings() async {
    state = await _localStorageService.getSettings();
  }

  void saveSettings() async {
    await _localStorageService.saveSettings(state);
  }
}


// StateNotifierProvider to provide the CounterNotifier
final phaseElapsedProvider = StateNotifierProvider<PhaseElapsedNotifier, List<double>>(
  (ref) => PhaseElapsedNotifier(),
);

class PhaseElapsedNotifier extends StateNotifier<List<double>> {
  PhaseElapsedNotifier() : super([0, 0, 0, 0, 0, 0]);

  static const Duration _updateDelay = Duration(milliseconds: 10);
  Timer? timer;
  
  void restart() {
    state = [0, 0, 0, 0, 0, 0];
  }
  // i'm sorry for THIS, but at some point I decided that it's easier to implement list as state
  // and not custom class which works... whick does not work
  void startUpdating(double hd, double cd, int reps) {
    state = [state[0], state[1], hd, cd, reps*2-0.5, 1];
    timer = Timer.periodic(_updateDelay, (timer) {
      if(state[0] >= state[2+state[1].round()%2]) {
        state = [0, state[1]+1, state[2], state[3], state[4], 1];
        if(state[1] > state[4]) {
          state[5] = 2;
          timer.cancel();
        }
      } else {
        state = [state[0] + 0.01, state[1], state[2], state[3], state[4], 1];
      }
    });
  }

  void stopUpdating() {
    timer!.cancel();
    state = [state[0], state[1], state[2], state[3], state[4], 0];
  }

  void finish() {
    state = [state[0], state[1], state[2], state[3], state[4], 2];
  }
}