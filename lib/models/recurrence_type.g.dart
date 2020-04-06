// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurrence_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecurrenceTypeAdapter extends TypeAdapter<RecurrenceType> {
  @override
  final typeId = 0;

  @override
  RecurrenceType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RecurrenceType.daily;
      case 1:
        return RecurrenceType.weekly;
      case 2:
        return RecurrenceType.monthly;
      case 3:
        return RecurrenceType.nonrecurring;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, RecurrenceType obj) {
    switch (obj) {
      case RecurrenceType.daily:
        writer.writeByte(0);
        break;
      case RecurrenceType.weekly:
        writer.writeByte(1);
        break;
      case RecurrenceType.monthly:
        writer.writeByte(2);
        break;
      case RecurrenceType.nonrecurring:
        writer.writeByte(3);
        break;
    }
  }
}
