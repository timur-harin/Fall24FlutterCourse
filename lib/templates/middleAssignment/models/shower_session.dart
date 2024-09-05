class ShowerSession {
  final DateTime date;
  final Duration totalDuration;
  final Duration hotDuration;
  final Duration coldDuration;
  final List<TemperaturePhase> phases;

  ShowerSession({
    required this.date,
    required this.totalDuration,
    required this.hotDuration,
    required this.coldDuration,
    required this.phases,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'totalDuration': totalDuration.inSeconds,
      'hotDuration': hotDuration.inSeconds,
      'coldDuration': coldDuration.inSeconds,
      'phases': phases.map((phase) => phase.toJson()).toList(),
    };
  }

  factory ShowerSession.fromJson(Map<String, dynamic> json) {
    return ShowerSession(
      date: DateTime.parse(json['date']),
      totalDuration: Duration(seconds: json['totalDuration']),
      hotDuration: Duration(seconds: json['hotDuration']),
      coldDuration: Duration(seconds: json['coldDuration']),
      phases: (json['phases'] as List)
          .map((phaseJson) => TemperaturePhase.fromJson(phaseJson))
          .toList(),
    );
  }
}

class TemperaturePhase {
  final Duration duration;
  final bool isHot;

  TemperaturePhase({
    required this.duration,
    required this.isHot,
  });

  Map<String, dynamic> toJson() {
    return {
      'duration': duration.inSeconds,
      'isHot': isHot,
    };
  }

  factory TemperaturePhase.fromJson(Map<String, dynamic> json) {
    return TemperaturePhase(
      duration: Duration(seconds: json['duration']),
      isHot: json['isHot'],
    );
  }
}
