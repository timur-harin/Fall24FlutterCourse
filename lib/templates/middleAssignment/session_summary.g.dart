// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models/session_summary.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionSummaryAdapter extends TypeAdapter<SessionSummary> {
  @override
  final int typeId = 0;

  @override
  SessionSummary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SessionSummary(
      date: fields[0] as DateTime,
      totalTime: fields[1] as int,
      phasesCompleted: fields[2] as int,
      rating: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, SessionSummary obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.totalTime)
      ..writeByte(2)
      ..write(obj.phasesCompleted)
      ..writeByte(3)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionSummaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
