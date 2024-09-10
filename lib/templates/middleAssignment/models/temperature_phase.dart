class TemperaturePhase {
  final String phaseType;
  final int duration;

  TemperaturePhase({required this.phaseType, required this.duration});

  Map<String, dynamic> toJson() {
    return {
      'phaseType': phaseType,
      'duration': duration,
    };
  }

  factory TemperaturePhase.fromJson(dynamic temp) {
    final res = TemperaturePhase(
      phaseType: temp['phaseType'],
      duration: temp['duration'],
    );

    return res;
  }
}
