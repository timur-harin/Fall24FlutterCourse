import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/shower_sessions_repository.dart';
import 'state.dart';

class SessionNotifier extends StateNotifier<SessionState?> {
  final ShowerSessionRepository _repository;

  SessionNotifier(this._repository) : super(null) {
    _loadSessionParams();
  }

  void _loadSessionParams() async {
    final session = await _repository.currentSession();
    if (session == null) return;
    state = SessionState(
      totalPhases: session.phases,
      phase: session.startPhase,
      timeRemainingSecs: session.totalDurationSecs,
      hotDurationSecs: session.hotDurationSecs,
      coldDurationSecs: session.coldDurationSecs,
    );
  }

  void onValveClick() => state = state?.switchedState;
}
