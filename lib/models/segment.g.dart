// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'segment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SegmentAdapter extends TypeAdapter<Segment> {
  @override
  final int typeId = 1;

  @override
  Segment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Segment(
      segmentId: fields[0] as int,
      programId: fields[1] as int,
      toComplete: fields[2] as ToComplete,
      valueToComplete: fields[3] as int,
      toMaintain: fields[4] as ToMaintain,
      valueToMaintain: fields[5] as int,
      intensity: fields[6] as Intensity,
    );
  }

  @override
  void write(BinaryWriter writer, Segment obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.segmentId)
      ..writeByte(1)
      ..write(obj.programId)
      ..writeByte(2)
      ..write(obj.toComplete)
      ..writeByte(3)
      ..write(obj.valueToComplete)
      ..writeByte(4)
      ..write(obj.toMaintain)
      ..writeByte(5)
      ..write(obj.valueToMaintain)
      ..writeByte(6)
      ..write(obj.intensity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SegmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
