import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/shower_session.dart';

@freezed
class SessionState {
  final ShowerPhase phase;
  final int phasesRemaining;
  final int timeRemainingSecs;

  SessionState({
    required this.phase,
    required this.phasesRemaining,
    required this.timeRemainingSecs,
  });
}
