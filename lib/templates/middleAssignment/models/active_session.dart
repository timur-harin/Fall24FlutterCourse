import 'temperature_phase.dart';

class ActiveSession {
  final int totalDuration;
  final int remainingTime;
  final TemperaturePhase currentPhase;
  final int temperatureInterval;
  final bool isActive;

  ActiveSession({
    this.totalDuration = 0,
    this.remainingTime = 0,
    this.currentPhase = TemperaturePhase.hot,
    this.temperatureInterval = 30,
    this.isActive = false,
  });

  ActiveSession copyWith({
    int? totalDuration,
    int? remainingTime,
    TemperaturePhase? currentPhase,
    int? temperatureInterval,
    bool? isActive,
  }) {
    return ActiveSession(
      totalDuration: totalDuration ?? this.totalDuration,
      remainingTime: remainingTime ?? this.remainingTime,
      currentPhase: currentPhase ?? this.currentPhase,
      temperatureInterval: temperatureInterval ?? this.temperatureInterval,
      isActive: isActive ?? this.isActive,
    );
  }
}
