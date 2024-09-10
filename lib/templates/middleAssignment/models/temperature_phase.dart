import 'package:hive/hive.dart';

part 'temperature_phase.g.dart';

@HiveType(typeId: 1)
class TemperaturePhase {
  @HiveField(0)
  final bool isHot;
  
  @HiveField(1)
  final Duration duration;

  TemperaturePhase({
    required this.isHot,
    required this.duration,
  });
}
