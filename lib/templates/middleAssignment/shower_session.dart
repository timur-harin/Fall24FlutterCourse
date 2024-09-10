
class ShowerSession {
  final List<TemperaturePhase> phases;
  final DateTime dateTime;
  final Duration totalDuration;
  double? rating;

  ShowerSession({
    required this.phases,
    required this.dateTime,
    required this.totalDuration,
    this.rating,
  });

  Map<String, dynamic> toJson() {
    return {
      'phases': phases.map((phase) => phase.toJson()).toList(),
      'dateTime': dateTime.toIso8601String(),
      'totalDuration': totalDuration.inMinutes,
      'rating': rating,
    };
  }

  factory ShowerSession.fromJson(Map<String, dynamic> json) {
    return ShowerSession(
      dateTime: DateTime.parse(json['dateTime']),
      totalDuration: Duration(seconds: json['totalDuration']),
      phases: (json['phases'] as List)
          .map((phaseJson) => TemperaturePhase.fromJson(phaseJson))
          .toList(),
      rating: json['rating']?.toDouble(),
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

  factory TemperaturePhase.fromJson(Map<String, dynamic> json) {
    return TemperaturePhase(
      duration: Duration(seconds: json['duration']),
      isHot: json['isHot'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'duration': duration,
      'isHot': isHot,
    };
  }
}

class UserPreferences {
  Duration hotDuration;
  Duration coldDuration;
  final double hotTemperature;
  final double coldTemperature;

  UserPreferences({
    this.hotDuration = const Duration(seconds: 30),
    this.coldDuration = const Duration(seconds: 30),
    this.hotTemperature = 40.0,
    this.coldTemperature = 20.0,
  });

  Map<String, dynamic> toJson() {
    return {
      'hotDuration': hotDuration,
      'coldDuration': coldDuration,
      'hotTemperature': hotTemperature,
      'coldTemperature': coldTemperature,
    };
  }
}
