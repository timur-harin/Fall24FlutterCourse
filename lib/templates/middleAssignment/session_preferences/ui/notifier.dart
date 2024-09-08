import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../session_preferences/ui/state.dart';
import '../../domain/shower_session.dart';
import '../../domain/shower_sessions_repository.dart';

class PreferencesNotifier extends StateNotifier<PreferencesState> {
  final ShowerSessionRepository _repository;

  PreferencesNotifier(this._repository) : super(PreferencesState()) {
    _loadLastSessionPreferences();
  }

  void _loadLastSessionPreferences() async {
    final session = await _repository.currentSession();
    state = PreferencesState(
      hotMinutes: session?.hotMinutes,
      hotSeconds: session?.hotSeconds,
      coldMinutes: session?.coldMinutes,
      coldSeconds: session?.coldSeconds,
      phases: session?.phases,
      startPhase: session?.startPhase,
    );
  }

  void updateSessionPreferences(PreferencesState Function(PreferencesState) update) async {
    state = update(state);
  }

  void storeCurrentSession() async {
    await _repository.updateCurrentSession(
        ShowerSession(
            startTimestamp: DateTime.now().toIso8601String(),
            hotMinutes: state.hotMinutes!,
            hotSeconds: state.hotSeconds!,
            coldMinutes: state.coldMinutes!,
            coldSeconds: state.coldSeconds!,
            phases: state.phases!,
            startPhase: state.startPhase!,
        )
    );
  }
}
