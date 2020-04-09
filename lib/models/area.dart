import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:zendaily/models/project.dart';

part 'area.g.dart';

@HiveType(typeId: 3)
class Area extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  HiveList<Project> projects;

  @HiveField(2)
  String description;

  Area({
    @required this.name,
    this.description = ''
  });
}