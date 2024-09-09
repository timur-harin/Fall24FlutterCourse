import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/shower_session.dart';

@freezed
class SessionState {
  final ShowerPhase phase;
  final int currentPhaseNumber;
  final int totalPhases;
  final int hotDurationSecs;
  final int coldDurationSecs;
  final int timeRemainingSecs;

  SessionState({
    required this.phase,
    required this.totalPhases,
    required this.hotDurationSecs,
    required this.coldDurationSecs,
    required this.timeRemainingSecs,
    this.currentPhaseNumber = 0,
  });

  SessionState copyWith({
    ShowerPhase? phase,
    int? totalPhases,
    int? hotDurationSecs,
    int? coldDurationSecs,
    int? timeRemainingSecs,
    int? currentPhaseNumber,
  }) => SessionState(
      phase: phase ?? this.phase,
      totalPhases: totalPhases ?? this.totalPhases,
      hotDurationSecs: hotDurationSecs ?? this.hotDurationSecs,
      coldDurationSecs: coldDurationSecs ?? this.coldDurationSecs,
      timeRemainingSecs: timeRemainingSecs ?? this.timeRemainingSecs,
      currentPhaseNumber: currentPhaseNumber ?? this.currentPhaseNumber,
  );

  SessionState get switchedState => copyWith(
    phase: _nextPhase,
    currentPhaseNumber: currentPhaseNumber + 1,
    timeRemainingSecs: _nextTimeRemainingSecs,
  );

  SessionState get withReducedSecond => switch (timeRemainingSecs) {
    0 => switchedState,
    _ => copyWith(timeRemainingSecs: timeRemainingSecs - 1),
  };

  ShowerPhase get _nextPhase => switch (phase) {
    ShowerPhase.hot => ShowerPhase.cold,
    ShowerPhase.cold => ShowerPhase.hot,
  };

  int get _nextTimeRemainingSecs => switch (phase) {
    ShowerPhase.hot => coldDurationSecs,
    ShowerPhase.cold => hotDurationSecs,
  };
}
