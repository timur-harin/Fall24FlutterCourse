import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/shower_session.dart';
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
      initialPhase: session.startPhase,
      startTimestamp: session.startTimestamp,
      totalPhases: session.phases,
      phase: session.startPhase,
      hotDurationSecs: session.hotDurationSecs,
      coldDurationSecs: session.coldDurationSecs,
    );
  }

  Future<void> storeSession() async {
    final session = state;
    if (session == null) return;

    await _repository.insertShowerSession(
      ShowerSession(
          startTimestamp: session.startTimestamp,
          hotMinutes: session.hotDurationSecs ~/ 60,
          hotSeconds: session.hotDurationSecs % 60,
          coldMinutes: session.coldDurationSecs ~/ 60,
          coldSeconds: session.coldDurationSecs % 60,
          phases: session.currentPhaseNumber + 1,
          startPhase: session.initialPhase,
      )
    );
  }

  void beginNextPhase() => state = state?.switchedState;

  void incrementDuration() => state = state?.withIncrementedDuration;
}
