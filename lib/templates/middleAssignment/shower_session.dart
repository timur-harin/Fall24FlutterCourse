import 'temperature_phase.dart';

class ShowerSession {
  final DateTime startTime;
  List<TemperaturePhase> phases;
  final int duration;
  int remainingTime;
  bool isHotPhase;
  int rating;

  ShowerSession({
    required this.startTime,
    required this.phases,
    required this.duration,
    this.remainingTime = 0,
    this.isHotPhase = true,
    this.rating = 0,
  });

  ShowerSession copyWith({
    DateTime? startTime,
    List<TemperaturePhase>? phases,
    int? duration,
    int? remainingTime,
    bool? isHotPhase,
    int? rating,
  }) {
    return ShowerSession(
      startTime: startTime ?? this.startTime,
      phases: phases ?? this.phases,
      duration: duration ?? this.duration,
      remainingTime: remainingTime ?? this.remainingTime,
      isHotPhase: isHotPhase ?? this.isHotPhase,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime.toIso8601String(),
      'phases': phases.map((e) => e.toJson()).toList(),
      'duration': duration,
      'remainingTime': remainingTime,
      'isHotPhase': isHotPhase,
      'rating': rating,
    };
  }

  static ShowerSession fromJson(Map<String, dynamic> json) {
    return ShowerSession(
      startTime: DateTime.parse(json['startTime']),
      phases: (json['phases'] as List)
          .map((item) => TemperaturePhase.fromJson(item))
          .toList(),
      duration: json['duration'],
      remainingTime: json['remainingTime'],
      isHotPhase: json['isHotPhase'],
      rating: json['rating'],
    );
  }
}
