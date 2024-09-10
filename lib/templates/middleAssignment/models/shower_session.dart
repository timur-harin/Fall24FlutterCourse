import 'package:hive/hive.dart';

part 'shower_session.g.dart';

@HiveType(typeId: 0)
class ShowerSession extends HiveObject {
  @HiveField(0)
  final DateTime dateTime;

  @HiveField(1)
  final List<TemperaturePhase> phases;

  @HiveField(2)
  final int totalDuration;

  @HiveField(3)
  final int? rating;

  final bool isPaused;

  ShowerSession({
    required this.dateTime,
    required this.phases,
    required this.totalDuration,
    this.isPaused = false,
    this.rating,
  });

  ShowerSession copyWith({
    DateTime? dateTime,
    List<TemperaturePhase>? phases,
    int? totalDuration,
    bool? isPaused,
    int? rating
  }) {
    return ShowerSession(
      dateTime: dateTime ?? this.dateTime,
      phases: phases ?? this.phases,
      totalDuration: totalDuration ?? this.totalDuration,
      isPaused: isPaused ?? this.isPaused,
      rating: rating ?? this.rating,
    );
  }
}



@HiveType(typeId: 1)
class TemperaturePhase extends HiveObject {
  @HiveField(0)
  final String type;
  @HiveField(1)
  final int duration;

  TemperaturePhase({required this.type, required this.duration});
}

@HiveType(typeId: 2)
class UserPreferences extends HiveObject {
  @HiveField(0)
  final int hotPhaseDuration;
  @HiveField(1)
  final int coldPhaseDuration;
  @HiveField(2)
  final int sessionLength;

  UserPreferences({
    this.hotPhaseDuration = 10,
    this.coldPhaseDuration = 10,
    this.sessionLength = 10,
  });

  UserPreferences copyWith({int? hotPhaseDuration, int? coldPhaseDuration, int? sessionLength}) {
    return UserPreferences(
      hotPhaseDuration: hotPhaseDuration ?? this.hotPhaseDuration,
      coldPhaseDuration: coldPhaseDuration ?? this.coldPhaseDuration,
      sessionLength: sessionLength ?? this.sessionLength,
    );
  }
}
