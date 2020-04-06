import 'package:hive/hive.dart';
import 'package:zendaily/models/recurrence_type.dart';

part 'task.g.dart';


@HiveType(adapterName: 'TaskAdapter', typeId: 1)
class Task {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String category;
  @HiveField(2)
  final RecurrenceType recurrenceType;


  Task({
    this.title,
    this.category,
    this.recurrenceType
  });

}