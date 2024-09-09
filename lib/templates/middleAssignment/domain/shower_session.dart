import 'package:freezed_annotation/freezed_annotation.dart';

const _startTimestampKey = 'start_timestamp';
const _hotMinutesKey = 'hot_minutes';
const _hotSecondsKey = 'hot_seconds';
const _coldMinutesKey = 'cold_minutes';
const _coldSecondsKey = 'cold_seconds';
const _phasesKey = 'phases';
const _startPhaseKey = 'start_phase';

@freezed
class ShowerSession {
  final String startTimestamp;
  final int phases;
  final ShowerPhase startPhase;

  final int hotMinutes;
  final int hotSeconds;

  final int coldMinutes;
  final int coldSeconds;

  late final String totalDuration;
  late final int totalDurationSecs;

  ShowerSession({
    required this.startTimestamp,
    required this.hotMinutes,
    required this.hotSeconds,
    required this.coldMinutes,
    required this.coldSeconds,
    required this.phases,
    required this.startPhase,
  }) {
    final hotSessionDurationSecs = _sessionDurationSecs(minutes: hotMinutes, seconds: hotSeconds);
    final coldSessionDurationSecs = _sessionDurationSecs(minutes: coldMinutes, seconds: coldSeconds);

    final firstPhaseTimes = phases ~/ 2 + phases % 2;
    final secondPhaseTimes = phases ~/ 2;

    final firstPhaseDurationSecs = startPhase == ShowerPhase.hot ? hotSessionDurationSecs : coldSessionDurationSecs;
    final secondPhaseDurationSecs = startPhase != ShowerPhase.hot ? hotSessionDurationSecs : coldSessionDurationSecs;

    final totalDurationTotalSecs = firstPhaseDurationSecs * firstPhaseTimes + secondPhaseDurationSecs * secondPhaseTimes;
    final totalDurationMinutes = totalDurationTotalSecs ~/ 60;
    final totalDurationSeconds = totalDurationTotalSecs % 60;

    totalDurationSecs = totalDurationTotalSecs;
    totalDuration = '$totalDurationMinutes:$totalDurationSeconds';
  }

  int _sessionDurationSecs({required int minutes, required int seconds}) =>
      minutes * 60 + seconds;

  factory ShowerSession.fromJson(Map<String, dynamic> json) =>
    ShowerSession(
        startTimestamp: json[_startTimestampKey],
        hotMinutes: json[_hotMinutesKey],
        hotSeconds: json[_hotSecondsKey],
        coldMinutes: json[_coldMinutesKey],
        coldSeconds: json[_coldSecondsKey],
        phases: json[_phasesKey],
        startPhase: ShowerPhase.values[json[_startPhaseKey]],
    );

  Map<String, Object> toMap() =>
      {
        _startTimestampKey: startTimestamp,
        _hotMinutesKey: hotMinutes,
        _hotSecondsKey: hotSeconds,
        _coldMinutesKey: coldMinutes,
        _coldSecondsKey: coldSeconds,
        _phasesKey: phases,
        _startPhaseKey: startPhase.index,
      };

  Map<String, dynamic> toJson() => toMap();
}

enum ShowerPhase { hot, cold; }
