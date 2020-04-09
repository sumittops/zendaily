// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resource.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResourceAdapter extends TypeAdapter<Resource> {
  @override
  final typeId = 6;

  @override
  Resource read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Resource()..data = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, Resource obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.data);
  }
}
