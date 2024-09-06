import 'package:hive/hive.dart' show HiveField, HiveType;

@HiveType(typeId: 0)
class ShowerSession {
  @HiveField(0)
  final DateTime startTimer;

  @HiveField(1)
  final int totalDuration;

  @HiveField(2)
  final List<TemperaturePhase> phases;

  ShowerSession({
    required this.startTimer,
    required this.totalDuration,
    required this.phases,
  });
}

class TemperaturePhase {
  final bool isHot;
  final int duration;

  TemperaturePhase({required this.isHot, required this.duration});
}
