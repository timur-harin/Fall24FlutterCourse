import 'package:hive/hive.dart';
import '../models/temperature_phase.dart';

class TemperaturePhaseAdapter extends TypeAdapter<TemperaturePhase> {
  @override
  final int typeId = 1;

  @override
  TemperaturePhase read(BinaryReader reader) {
    final isHot = reader.readBool();
    final duration = Duration(milliseconds: reader.readInt());
    return TemperaturePhase(isHot: isHot, duration: duration);
  }

  @override
  void write(BinaryWriter writer, TemperaturePhase obj) {
    writer.writeBool(obj.isHot);
    writer.writeInt(obj.duration.inMilliseconds);
  }
}
