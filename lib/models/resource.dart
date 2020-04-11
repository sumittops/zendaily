import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'resource.g.dart';

@HiveType(typeId: 4)
class Resource extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String data;

  @HiveField(2)
  String projectId;

  Resource({
    @required this.data,
    @required this.projectId
  }) : id = Uuid().v1();

}