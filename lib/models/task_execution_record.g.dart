// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_execution_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskExecutionRecordAdapter extends TypeAdapter<TaskExecutionRecord> {
  @override
  final typeId = 2;

  @override
  TaskExecutionRecord read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskExecutionRecord(
      startTime: fields[0] as DateTime,
    )
      ..endTime = fields[1] as DateTime
      ..duration = fields[2] as Duration;
  }

  @override
  void write(BinaryWriter writer, TaskExecutionRecord obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.startTime)
      ..writeByte(1)
      ..write(obj.endTime)
      ..writeByte(2)
      ..write(obj.duration);
  }
}
