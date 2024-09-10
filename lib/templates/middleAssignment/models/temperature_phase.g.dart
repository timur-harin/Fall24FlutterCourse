// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temperature_phase.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

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
      duration: Duration(milliseconds: fields[1] as int),
    );
  }

  @override
  void write(BinaryWriter writer, TemperaturePhase obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.isHot)
      ..writeByte(1)
      ..write(obj.duration.inMilliseconds);
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
