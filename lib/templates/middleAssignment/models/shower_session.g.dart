// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shower_session.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShowerSessionAdapter extends TypeAdapter<ShowerSession> {
  @override
  final int typeId = 0;

  @override
  ShowerSession read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShowerSession(
      dateTime: fields[0] as DateTime,
      phases: (fields[1] as List).cast<TemperaturePhase>(),
      totalDuration: fields[2] as int,
      rating: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ShowerSession obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.dateTime)
      ..writeByte(1)
      ..write(obj.phases)
      ..writeByte(2)
      ..write(obj.totalDuration)
      ..writeByte(3)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShowerSessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TemperaturePhaseAdapter extends TypeAdapter<TemperaturePhase> {
  @override
  final int typeId = 1;

  @override
  TemperaturePhase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TemperaturePhase(
      type: fields[0] as String,
      duration: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TemperaturePhase obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TemperaturePhaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserPreferencesAdapter extends TypeAdapter<UserPreferences> {
  @override
  final int typeId = 2;

  @override
  UserPreferences read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserPreferences(
      hotPhaseDuration: fields[0] as int,
      coldPhaseDuration: fields[1] as int,
      sessionLength: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UserPreferences obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.hotPhaseDuration)
      ..writeByte(1)
      ..write(obj.coldPhaseDuration)
      ..writeByte(2)
      ..write(obj.sessionLength);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserPreferencesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
