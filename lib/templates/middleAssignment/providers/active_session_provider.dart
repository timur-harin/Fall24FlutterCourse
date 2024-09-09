import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../models/active_session.dart';
import 'session_preferences_provider.dart';
import 'session_summary_provider.dart';
import '../models/session_summary.dart';
import '../models/temperature_phase.dart';

class ActiveSessionNotifier extends StateNotifier<ActiveSession> {
  final StateNotifierProviderRef ref;
  Timer? _timer;

  ActiveSessionNotifier(this.ref) : super(ActiveSession());

  void startSession(BuildContext context) {
  final preferences = ref.read(sessionPreferencesProvider);
  state = ActiveSession(
    totalDuration: preferences.duration * 60,
    remainingTime: preferences.duration * 60,
    currentPhase: preferences.startingTemperature,
    temperatureInterval: preferences.temperatureInterval,
    isActive: true,
  );
  _startTimer(context);
}


  void _startTimer( BuildContext context) {
  _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    if (state.remainingTime > 0) {
      state = state.copyWith(
        remainingTime: state.remainingTime - 1,
        currentPhase: (state.remainingTime % state.temperatureInterval == 0)
            ? (state.currentPhase == TemperaturePhase.hot
                ? TemperaturePhase.cold
                : TemperaturePhase.hot)
            : state.currentPhase,
      );
    } else {
      print('Timer expired');
      endSession(context);
    }
  });
}


  void pauseSession() {
    _timer?.cancel();
    state = state.copyWith(isActive: false);
  }

  void resumeSession( BuildContext context) {
    state = state.copyWith(isActive: true);
    _startTimer(context);
  }

  void endSession(BuildContext context) {
  _timer?.cancel();
  final elapsed = state.totalDuration - state.remainingTime;

  print('Ending session. Total duration: ${state.totalDuration}, Remaining time: ${state.remainingTime}, Elapsed time: $elapsed');

  final summary = SessionSummary(
    date: DateTime.now(),
    totalTime: elapsed,
    phasesCompleted: elapsed ~/ state.temperatureInterval,
    rating: 0,
  );

  ref.read(currentSessionSummaryProvider.notifier).state = summary;

  Navigator.pushReplacementNamed(context, '/summary');
}


}

final activeSessionProvider = StateNotifierProvider<ActiveSessionNotifier, ActiveSession>((ref) {
  return ActiveSessionNotifier(ref);
});
