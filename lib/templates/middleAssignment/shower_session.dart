
class ShowerSession {
  final List<TemperaturePhase> phases;
  final DateTime dateTime;
  final Duration totalDuration;

  ShowerSession({
    required this.phases,
    required this.dateTime,
    required this.totalDuration,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'dateTime': dateTime,
      'totalDuration': totalDuration,
      'phases': phases,
    };
  }

  factory ShowerSession.fromJson(Map<String, dynamic> json) {
    return ShowerSession(
      dateTime: DateTime.parse(json['dateTime']),
      totalDuration: Duration(seconds: json['totalDuration']),
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

  factory TemperaturePhase.fromJson(Map<String, dynamic> json) {
    return TemperaturePhase(
      duration: Duration(seconds: json['duration']),
      isHot: json['isHot'],
    );
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
