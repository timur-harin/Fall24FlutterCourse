import 'package:hive/hive.dart';

part 'shower_session.g.dart';

@HiveType(typeId: 0)
class ShowerSession extends HiveObject {
  @HiveField(0)
  final DateTime startTime;

  @HiveField(1)
  final DateTime endTime;

  @HiveField(2)
  final int hotDuration;

  @HiveField(3)
  final int coldDuration;

  ShowerSession({
    required this.startTime,
    required this.endTime,
    required this.hotDuration,
    required this.coldDuration, 
  });
}
