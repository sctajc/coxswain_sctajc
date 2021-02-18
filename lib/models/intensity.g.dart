// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intensity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IntensityAdapter extends TypeAdapter<Intensity> {
  @override
  final int typeId = 4;

  @override
  Intensity read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Intensity.WarmUpBlue;
      case 1:
        return Intensity.EasyGreen;
      case 2:
        return Intensity.MediumYellow;
      case 3:
        return Intensity.HardOrange;
      case 4:
        return Intensity.CoolDownGrey;
      case 5:
        return Intensity.StretchingPurple;
      case 6:
        return Intensity.RestWhite;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, Intensity obj) {
    switch (obj) {
      case Intensity.WarmUpBlue:
        writer.writeByte(0);
        break;
      case Intensity.EasyGreen:
        writer.writeByte(1);
        break;
      case Intensity.MediumYellow:
        writer.writeByte(2);
        break;
      case Intensity.HardOrange:
        writer.writeByte(3);
        break;
      case Intensity.CoolDownGrey:
        writer.writeByte(4);
        break;
      case Intensity.StretchingPurple:
        writer.writeByte(5);
        break;
      case Intensity.RestWhite:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IntensityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
