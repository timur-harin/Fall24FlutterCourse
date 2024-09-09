import 'package:hive/hive.dart';

part '../session_summary.g.dart';

@HiveType(typeId: 0)
class SessionSummary extends HiveObject {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final int totalTime;

  @HiveField(2)
  final int phasesCompleted;

  @HiveField(3)
  final double rating;

  SessionSummary({
    required this.date,
    required this.totalTime,
    required this.phasesCompleted,
    required this.rating,
  });

  SessionSummary copyWith({
    DateTime? date,
    int? totalTime,
    int? phasesCompleted,
    double? rating,
  }) {
    return SessionSummary(
      date: date ?? this.date,
      totalTime: totalTime ?? this.totalTime,
      phasesCompleted: phasesCompleted ?? this.phasesCompleted,
      rating: rating ?? this.rating,
    );
  }
}
