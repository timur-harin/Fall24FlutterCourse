// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionEntityImpl _$$SessionEntityImplFromJson(Map<String, dynamic> json) =>
    _$SessionEntityImpl(
      amountOfSets: (json['amountOfSets'] as num).toInt(),
      dateAndTime: DateTime.parse(json['dateAndTime'] as String),
      startWithCold: json['startWithCold'] as bool,
      coldIntervalSeconds: (json['coldIntervalSeconds'] as num).toInt(),
      hotIntervalSeconds: (json['hotIntervalSeconds'] as num).toInt(),
    );

Map<String, dynamic> _$$SessionEntityImplToJson(_$SessionEntityImpl instance) =>
    <String, dynamic>{
      'amountOfSets': instance.amountOfSets,
      'dateAndTime': SessionEntity.dateTimeToIsoString(instance.dateAndTime),
      'startWithCold': instance.startWithCold,
      'coldIntervalSeconds': instance.coldIntervalSeconds,
      'hotIntervalSeconds': instance.hotIntervalSeconds,
    };
