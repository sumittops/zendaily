import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:zendaily/models/recurrence_type.dart';


part 'task.g.dart';


@HiveType(typeId: 6)
class Task extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final 
  String title;

  @HiveField(2)
  final RecurrenceType recurrenceType;

  @HiveField(3)
  final String areaId;

  @HiveField(4)
  final String projectId;
  
  Task({
    @required this.title,
    @required this.recurrenceType,
    @required this.areaId,
    @required this.projectId,
  }) : id = Uuid().v1();

}