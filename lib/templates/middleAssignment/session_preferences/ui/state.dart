import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/shower_session.dart';

@freezed
class PreferencesState {
  final int? phases;
  final ShowerPhase? startPhase;

  final int? hotMinutes;
  final int? hotSeconds;

  final int? coldMinutes;
  final int? coldSeconds;

  PreferencesState({
    this.hotMinutes,
    this.hotSeconds,
    this.coldMinutes,
    this.coldSeconds,
    this.phases,
    this.startPhase = ShowerPhase.hot,
  });

  PreferencesState copyWith({
    int? hotMinutes,
    int? hotSeconds,
    int? coldMinutes,
    int? coldSeconds,
    int? phases,
    ShowerPhase? startPhase = ShowerPhase.hot,
  }) => PreferencesState(
    hotMinutes: hotMinutes,
    hotSeconds: hotSeconds,
    coldMinutes: coldMinutes,
    coldSeconds: coldSeconds,
    phases: phases,
    startPhase: startPhase,
  );
}
