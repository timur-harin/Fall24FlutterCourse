import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shower_session.dart';
import 'user_preferences.dart';

final preferencesProvider =
StateNotifierProvider<UserPreferencesNotifier, UserPreferences>((ref) {
  return UserPreferencesNotifier();
});

class UserPreferencesNotifier extends StateNotifier<UserPreferences> {
  UserPreferencesNotifier()
      : super(UserPreferences(hotPhase: 10, coldPhase: 15, totalPhases: 3));

  void updatePreferences(UserPreferences newPrefs) {
    state = newPrefs;
  }
}

final sessionProvider =
StateNotifierProvider<SessionNotifier, ShowerSession?>((ref) {
  return SessionNotifier();
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
