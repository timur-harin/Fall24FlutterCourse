import 'package:hive/hive.dart';
import 'temperature_phase.dart';

part 'shower_session.g.dart';

@HiveType(typeId: 0)
class ShowerSession {
  @HiveField(0)
  final List<TemperaturePhase> phases;
  
  @HiveField(1)
  final Duration totalTime;
  
  @HiveField(2)
  final DateTime dateTime;

  @HiveField(3)
  final int rating;

  ShowerSession({
    required this.phases,
    required this.totalTime,
    required this.dateTime,
    required this.rating,
  });

  ShowerSession copyWith({
    List<TemperaturePhase>? phases,
    Duration? totalTime,
    DateTime? dateTime,
    int? rating,
  }) {
    return ShowerSession(
      phases: phases ?? this.phases,
      totalTime: totalTime ?? this.totalTime,
      dateTime: dateTime ?? this.dateTime,
      rating: rating ?? this.rating,
    );
  }
}
