import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zendaily/models/recurrence_type.dart';
import 'package:zendaily/models/task.dart';
import 'package:zendaily/app.dart';
import 'package:zendaily/models/task_execution_record.dart';

void main() async {
  await  Hive.initFlutter();
  Hive.registerAdapter<RecurrenceType>(RecurrenceTypeAdapter());
  Hive.registerAdapter<Task>(TaskAdapter());
  Hive.registerAdapter<TaskExecutionRecord>(TaskExecutionRecordAdapter());

  runApp(App());
}