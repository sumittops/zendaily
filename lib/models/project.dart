import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'project.g.dart';

@HiveType(typeId: 2)
class Project extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final DateTime deadline;

  @HiveField(3)
  String areaId;

  @HiveField(4)
  String description;
  
  Project({
    @required this.name,
    @required this.areaId,
    @required this.deadline,
    this.description = ''
  }) : id = Uuid().v1() ;

}