import 'temperature_phase.dart';

class SessionPreferences {
  final int duration;
  final int temperatureInterval;
  final TemperaturePhase startingTemperature;

  SessionPreferences({
    this.duration = 10,
    this.temperatureInterval = 30,
    this.startingTemperature = TemperaturePhase.hot,
  });

  SessionPreferences copyWith({
    int? duration,
    int? temperatureInterval,
    TemperaturePhase? startingTemperature,
  }) {
    return SessionPreferences(
      duration: duration ?? this.duration,
      temperatureInterval: temperatureInterval ?? this.temperatureInterval,
      startingTemperature: startingTemperature ?? this.startingTemperature,
    );
  }
}
