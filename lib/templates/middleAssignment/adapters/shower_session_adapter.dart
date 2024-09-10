
import 'package:hive_flutter/hive_flutter.dart';
import '../models/temperature_phase.dart';
import '../models/shower_session.dart';

class ShowerSessionAdapter extends TypeAdapter<ShowerSession> {
  @override
  final int typeId = 0;

  @override
  ShowerSession read(BinaryReader reader) {
    final numOfPhases = reader.readInt();
    final phases = List<TemperaturePhase>.generate(numOfPhases, (_) {
      return reader.read() as TemperaturePhase;
    });

    final totalTime = Duration(milliseconds: reader.readInt());
    
    final dateTimeMillis = reader.readInt();
    final dateTime = DateTime.fromMillisecondsSinceEpoch(dateTimeMillis);
    
    final rating = reader.readInt();

    return ShowerSession(
      phases: phases, 
      totalTime: totalTime, 
      dateTime: dateTime,
      rating: rating,
    );
  }

  @override
  void write(BinaryWriter writer, ShowerSession obj) {
    writer.writeInt(obj.phases.length);
    for (var phase in obj.phases) {
      writer.write(phase);
    }
    writer.writeInt(obj.totalTime.inMilliseconds);
    
    writer.writeInt(obj.dateTime.millisecondsSinceEpoch);

    writer.writeInt(obj.rating);
  }
}
