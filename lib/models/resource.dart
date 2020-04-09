import 'package:hive/hive.dart';

part 'resource.g.dart';

@HiveType(typeId: 6)
class Resource extends HiveObject {
  @HiveField(0)
  String data;  
}