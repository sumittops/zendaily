import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'area.g.dart';

@HiveType(typeId: 1)
class Area extends HiveObject {

  @HiveField(0)
  String id;
  
  @HiveField(1)
  String name;

  @HiveField(2)
  int color;

  Area({
    @required this.name,
    @required this.color
  }) : id = Uuid().v1();
}