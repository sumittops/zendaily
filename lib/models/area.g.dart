// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AreaAdapter extends TypeAdapter<Area> {
  @override
  final typeId = 3;

  @override
  Area read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Area(
      name: fields[0] as String,
      description: fields[2] as String,
    )..projects = (fields[1] as HiveList)?.castHiveList();
  }

  @override
  void write(BinaryWriter writer, Area obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.projects)
      ..writeByte(2)
      ..write(obj.description);
  }
}
