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

  Area({
    @required this.name
  }) : id = Uuid().v1();
}