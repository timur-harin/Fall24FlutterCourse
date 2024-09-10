import 'package:hive/hive.dart';

part 'shower_session.g.dart';

@HiveType(typeId: 0)
class ShowerSession extends HiveObject {
  @HiveField(0)
  final List<TemperaturePhase> phases;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final int totalDuration;

  ShowerSession({
    required this.phases,
    required this.date,
    required this.totalDuration,
    required bool interrupted,
  });
}

@HiveType(typeId: 1)
class TemperaturePhase {
  @HiveField(0)
  final bool isHot;

  @HiveField(1)
  final int duration;

  TemperaturePhase({
    required this.isHot,
    required this.duration,
  });
}
