import 'package:hive/hive.dart';

part 'shower_session.g.dart';

@HiveType(typeId: 0)
class ShowerSession {
  @HiveField(0)
  final List<TemperaturePhase> phases;

  ShowerSession({required this.phases});
}

@HiveType(typeId: 1)
class TemperaturePhase {
  @HiveField(0)
  final bool isHot; // true = Hot, false = Cold

  @HiveField(1)
  final int duration; // Duration in seconds

  TemperaturePhase({required this.isHot, required this.duration});
}
