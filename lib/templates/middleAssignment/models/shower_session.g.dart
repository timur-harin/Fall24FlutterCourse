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
      totalTime: Duration(milliseconds: fields[1] as int),
      dateTime: fields[2] as DateTime,
      rating: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ShowerSession obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.phases)
      ..writeByte(1)
      ..write(obj.totalTime.inMilliseconds)
      ..writeByte(2)
      ..write(obj.dateTime)
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
