// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_execution_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskExecutionRecordAdapter extends TypeAdapter<TaskExecutionRecord> {
  @override
  final typeId = 5;

  @override
  TaskExecutionRecord read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskExecutionRecord(
      startTime: fields[1] as DateTime,
      taskId: fields[4] as String,
    )
      ..endTime = fields[2] as DateTime
      ..duration = fields[3] as Duration;
  }

  @override
  void write(BinaryWriter writer, TaskExecutionRecord obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.endTime)
      ..writeByte(3)
      ..write(obj.duration)
      ..writeByte(4)
      ..write(obj.taskId);
  }
}
