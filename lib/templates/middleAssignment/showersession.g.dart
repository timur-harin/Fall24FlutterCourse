// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'showersession.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowerSession _$ShowerSessionFromJson(Map<String, dynamic> json) =>
    ShowerSession(
      hotDuration: (json['hotDuration'] as num).toDouble(),
      coldDuration: (json['coldDuration'] as num).toDouble(),
      hotTemperature: (json['hotTemperature'] as num).toDouble(),
      coldTemperature: (json['coldTemperature'] as num).toDouble(),
      reps: (json['reps'] as num).toInt(),
      timeCompleted: DateTime.parse(json['timeCompleted'] as String),
    );

Map<String, dynamic> _$ShowerSessionToJson(ShowerSession instance) =>
    <String, dynamic>{
      'hotDuration': instance.hotDuration,
      'coldDuration': instance.coldDuration,
      'hotTemperature': instance.hotTemperature,
      'coldTemperature': instance.coldTemperature,
      'reps': instance.reps,
      'timeCompleted': instance.timeCompleted.toIso8601String(),
    };
