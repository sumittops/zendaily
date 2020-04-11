import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task_execution_record.g.dart';

@HiveType(typeId: 5)
class TaskExecutionRecord extends HiveObject {
  
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime startTime;
  
  @HiveField(2)
  DateTime endTime;

  @HiveField(3)
  Duration duration;

  @HiveField(4)
  final String taskId;
  
  TaskExecutionRecord({
    @required this.startTime,
    @required this.taskId 
  }): id = Uuid().v1();

  void endExecution(DateTime endDateTime) {
    endTime = endDateTime;
    duration = endTime.difference(startTime);
  }

}