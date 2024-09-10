import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'session_preferences_state.dart';

class CreateSessionNotifier extends StateNotifier<CreateSessionState> {
  CreateSessionNotifier() : super(const CreateSessionState());

  void toggleStartWithCold() {
    state = state.copyWith(startWithCold: !state.startWithCold);
  }

  void updateNumberOfSets(int value) {
    state = state.copyWith(numberOfSets: value);
  }

  void updateColdIntervalMinutes(int value) {
    state = state.copyWith(coldIntervalSeconds: value);
  }

  void updateHotIntervalMinutes(int value) {
    state = state.copyWith(hotIntervalSeconds: value);
  }
}