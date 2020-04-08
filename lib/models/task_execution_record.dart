import 'package:hive/hive.dart';

part 'task_execution_record.g.dart';

@HiveType(typeId: 2)
class TaskExecutionRecord extends HiveObject {
  @HiveField(0)
  final DateTime startTime;
  
  @HiveField(1)
  DateTime endTime;
  
  @HiveField(2)
  Duration duration;
  
  
  TaskExecutionRecord({ this.startTime });

  void updateDuration() {
    duration = endTime.difference(startTime);
  }

}