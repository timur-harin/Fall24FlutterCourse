import 'package:freezed_annotation/freezed_annotation.dart';

import 'session_preferences_state.dart';

part 'session_overview_state.freezed.dart';

@freezed
class SessionOverviewState with _$SessionOverviewState {
  const factory SessionOverviewState({
    required CreateSessionState createdSession,
    @Default(1) int currentSet,
    required int secondsLeft,
    @Default(false) bool finished,
    @Default(SessionState.notStarted) SessionState sessionState,
  }) = _SessionOverviewState;
}

enum SessionState {
  notStarted,
  started,
  finished;
}
