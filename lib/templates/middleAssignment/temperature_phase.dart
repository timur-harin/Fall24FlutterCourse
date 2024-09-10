class TemperaturePhase {
  final String phaseType;
  final int duration;
  final int actualDuration;

  TemperaturePhase({
    required this.phaseType,
    required this.duration,
    this.actualDuration = 0,
  });

  TemperaturePhase copyWith({
    String? phaseType,
    int? duration,
    int? actualDuration,
  }) {
    return TemperaturePhase(
      phaseType: phaseType ?? this.phaseType,
      duration: duration ?? this.duration,
      actualDuration: actualDuration ?? this.actualDuration,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phaseType': phaseType,
      'duration': duration,
      'actualDuration': actualDuration,
    };
  }

  static TemperaturePhase fromJson(Map<String, dynamic> json) {
    return TemperaturePhase(
      phaseType: json['phaseType'],
      duration: json['duration'],
      actualDuration: json['actualDuration'] ?? 0,
    );
  }
}
