// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_bird.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BirdAdapter extends TypeAdapter<Bird> {
  @override
  final int typeId = 0;

  @override
  Bird read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bird(
      name: fields[0] as String,
      family: fields[1] as String,
      order: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Bird obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.family)
      ..writeByte(2)
      ..write(obj.order);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BirdAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
