import 'package:hive/hive.dart';
import 'package:zendaily/models/recurrence_type.dart';
import 'package:zendaily/models/task_execution_record.dart';


part 'task.g.dart';


@HiveType(adapterName: 'TaskAdapter', typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String category;
  @HiveField(2)
  final RecurrenceType recurrenceType;
  @HiveField(3)
  HiveList<TaskExecutionRecord> executionRecord;

  Task({
    this.title,
    this.category,
    this.recurrenceType
  });

}