import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:zendaily/models/task.dart';

part 'project.g.dart';

@HiveType(typeId: 4)
class Project extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final DateTime deadline;

  @HiveField(2)
  HiveList<Task> tasks;

  @HiveField(3)
  HiveList<dynamic> resources;

  Project({
    @required this.name,
    @required this.deadline
  });

}