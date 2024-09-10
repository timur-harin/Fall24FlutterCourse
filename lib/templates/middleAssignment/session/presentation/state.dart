import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/shower_session.dart';

@freezed
class SessionState {
  final ShowerPhase initialPhase;
  final String startTimestamp;
  final ShowerPhase phase;
  final int currentPhaseNumber;
  final int totalPhases;
  final int hotDurationSecs;
  final int coldDurationSecs;
  final int passedDuration;
  late final int currentPhaseDurationSecs;
  late final bool hasNextPhase;

  SessionState({
    required this.initialPhase,
    required this.startTimestamp,
    required this.phase,
    required this.totalPhases,
    required this.hotDurationSecs,
    required this.coldDurationSecs,
    this.passedDuration = 0,
    this.currentPhaseNumber = 0,
  }) {
    currentPhaseDurationSecs = switch (phase) {
      ShowerPhase.hot => hotDurationSecs,
      ShowerPhase.cold => coldDurationSecs,
    };

    hasNextPhase = currentPhaseNumber + 1 < totalPhases;
  }

  SessionState copyWith({
    ShowerPhase? phase,
    int? totalPhases,
    int? hotDurationSecs,
    int? coldDurationSecs,
    int? passedDuration,
    int? currentPhaseNumber,
  }) => SessionState(
      initialPhase: initialPhase,
      startTimestamp: startTimestamp,
      phase: phase ?? this.phase,
      totalPhases: totalPhases ?? this.totalPhases,
      hotDurationSecs: hotDurationSecs ?? this.hotDurationSecs,
      coldDurationSecs: coldDurationSecs ?? this.coldDurationSecs,
      passedDuration: passedDuration ?? this.passedDuration,
      currentPhaseNumber: currentPhaseNumber ?? this.currentPhaseNumber,
  );

  SessionState get switchedState => switch (hasNextPhase) {
    false => this,
    true => copyWith(
      phase: _nextPhase,
      currentPhaseNumber: currentPhaseNumber + 1,
    ),
  };

  SessionState get withIncrementedDuration => copyWith(
    passedDuration: passedDuration + 1
  );

  int? get nextPhaseDurationSecs => switch (hasNextPhase) {
    false => null,
    true => switch (phase) {
      ShowerPhase.hot => coldDurationSecs,
      ShowerPhase.cold => hotDurationSecs,
    },
  };

  ShowerPhase get _nextPhase => switch (phase) {
    ShowerPhase.hot => ShowerPhase.cold,
    ShowerPhase.cold => ShowerPhase.hot,
  };
}
