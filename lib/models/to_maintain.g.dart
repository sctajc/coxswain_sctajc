// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'to_maintain.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToMaintainAdapter extends TypeAdapter<ToMaintain> {
  @override
  final int typeId = 3;

  @override
  ToMaintain read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ToMaintain.None;
      case 1:
        return ToMaintain.Speed;
      case 2:
        return ToMaintain.Pulse;
      case 3:
        return ToMaintain.StrokeRate;
      case 4:
        return ToMaintain.Power;
      default:
        return ToMaintain.None;
    }
  }

  @override
  void write(BinaryWriter writer, ToMaintain obj) {
    switch (obj) {
      case ToMaintain.None:
        writer.writeByte(0);
        break;
      case ToMaintain.Speed:
        writer.writeByte(1);
        break;
      case ToMaintain.Pulse:
        writer.writeByte(2);
        break;
      case ToMaintain.StrokeRate:
        writer.writeByte(3);
        break;
      case ToMaintain.Power:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToMaintainAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
