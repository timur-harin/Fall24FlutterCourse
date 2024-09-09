import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/session_preferences.dart';
import '../models/temperature_phase.dart';

class SessionPreferencesNotifier extends StateNotifier<SessionPreferences> {
  SessionPreferencesNotifier() : super(SessionPreferences());

  void setDuration(int duration) {
    state = state.copyWith(duration: duration);
  }

  void setTemperatureInterval(int interval) {
    state = state.copyWith(temperatureInterval: interval);
  }

  void setStartingTemperature(TemperaturePhase temperature) {
    state = state.copyWith(startingTemperature: temperature);
  }
}

final sessionPreferencesProvider = StateNotifierProvider<SessionPreferencesNotifier, SessionPreferences>((ref) {
  return SessionPreferencesNotifier();
});
