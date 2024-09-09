// ignore_for_file: curly_braces_in_flow_control_structures

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

  late final bool isSessionCreationReady;

  PreferencesState({
    this.hotMinutes,
    this.hotSeconds,
    this.coldMinutes,
    this.coldSeconds,
    this.phases,
    this.startPhase = ShowerPhase.hot,
  }) {
    if (hotMinutes == null) isSessionCreationReady = false;
    else if (hotSeconds == null) isSessionCreationReady = false;
    else if ((hotMinutes ?? 0) + (hotSeconds ?? 0) == 0) isSessionCreationReady = false;
    else if (coldMinutes == null) isSessionCreationReady = false;
    else if (coldSeconds == null) isSessionCreationReady = false;
    else if ((coldMinutes ?? 0) + (coldSeconds ?? 0) == 0) isSessionCreationReady = false;
    else if (phases == null || phases == 0) isSessionCreationReady = false;
    else if (startPhase == null) isSessionCreationReady = false;
    else isSessionCreationReady = true;
  }

  PreferencesState copyWith({
    int? hotMinutes,
    int? hotSeconds,
    int? coldMinutes,
    int? coldSeconds,
    int? phases,
    ShowerPhase? startPhase = ShowerPhase.hot,
  }) => PreferencesState(
    hotMinutes: hotMinutes ?? this.hotMinutes,
    hotSeconds: hotSeconds ?? this.hotSeconds,
    coldMinutes: coldMinutes ?? this.coldMinutes,
    coldSeconds: coldSeconds ?? this.coldSeconds,
    phases: phases ?? this.phases,
    startPhase: startPhase ?? this.startPhase,
  );
}
