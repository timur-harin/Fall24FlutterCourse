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
      phases: (fields[0] as List).cast<TemperaturePhase>(),
      date: fields[1] as DateTime,
      totalDuration: fields[2] as int, interrupted: false,
    );
  }

  @override
  void write(BinaryWriter writer, ShowerSession obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.phases)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.totalDuration);
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
      isHot: fields[0] as bool,
      duration: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TemperaturePhase obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.isHot)
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
