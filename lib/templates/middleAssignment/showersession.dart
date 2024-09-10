import 'package:json_annotation/json_annotation.dart';

part 'showersession.g.dart';

final emptyShowerSession = ShowerSession(coldDuration: 20, coldTemperature: 0, hotDuration: 20, hotTemperature: 0, reps: 2, timeCompleted: DateTime.now());

@JsonSerializable()
class ShowerSession {
    double hotDuration;

    double coldDuration;
    double hotTemperature;
    double coldTemperature;
    int reps;
    DateTime timeCompleted;

  ShowerSession({
    required this.hotDuration,
    required this.coldDuration,
    required this.hotTemperature,
    required this.coldTemperature,
    required this.reps,
    required this.timeCompleted
  });
  factory ShowerSession.fromJson(Map<String, dynamic> json) => _$ShowerSessionFromJson(json);

  Map<String, dynamic> toJson() => _$ShowerSessionToJson(this);
}


/*import 'package:freezed_annotation/freezed_annotation.dart';
part 'showersession.g.dart';
part 'showersession.freezed.dart';

@freezed
class ShowerSession with _$ShowerSession {
  const factory ShowerSession({
    required double hotDuration,
    required double coldDuration,
    required double hotTemperature,
    required double coldTemperature,
    required double reps,
    required DateTime timeCompleted
  }) = _ShowerSession;

  factory ShowerSession.fromJson(Map<String, Object?> json) => _$ShowerSessionFromJson(json);
}*/