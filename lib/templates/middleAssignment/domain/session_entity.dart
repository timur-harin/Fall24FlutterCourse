import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_entity.freezed.dart';
part 'session_entity.g.dart';

@freezed
class SessionEntity with _$SessionEntity {
  const factory SessionEntity({
    required int amountOfSets,
    @JsonKey(
        toJson: SessionEntity.dateTimeToIsoString, fromJson: DateTime.parse)
    required DateTime dateAndTime,
    required bool startWithCold,
    required int coldIntervalSeconds,
    required int hotIntervalSeconds,
  }) = _SessionEntity;

  static String dateTimeToIsoString(DateTime dateTime) =>
      dateTime.toIso8601String();

  factory SessionEntity.fromJson(Map<String, dynamic> json) =>
      _$SessionEntityFromJson(json);
}

extension SessionEntityX on SessionEntity {
  Duration get totalDuration {
    return Duration(
      seconds: amountOfSets * (coldIntervalSeconds + hotIntervalSeconds),
    );
  }
}
