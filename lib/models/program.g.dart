// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProgramAdapter extends TypeAdapter<Program> {
  @override
  final int typeId = 0;

  @override
  Program read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Program(
      programId: fields[0] as int,
      programName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Program obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.programId)
      ..writeByte(1)
      ..write(obj.programName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgramAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
