// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'to_complete.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToCompleteAdapter extends TypeAdapter<ToComplete> {
  @override
  final int typeId = 2;

  @override
  ToComplete read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ToComplete.Duration;
      case 1:
        return ToComplete.Distance;
      case 2:
        return ToComplete.TotalStrokes;
      case 3:
        return ToComplete.Energy;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, ToComplete obj) {
    switch (obj) {
      case ToComplete.Duration:
        writer.writeByte(0);
        break;
      case ToComplete.Distance:
        writer.writeByte(1);
        break;
      case ToComplete.TotalStrokes:
        writer.writeByte(2);
        break;
      case ToComplete.Energy:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToCompleteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
