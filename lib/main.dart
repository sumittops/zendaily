import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zendaily/models/models.dart';
import 'package:zendaily/app.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<RecurrenceType>(RecurrenceTypeAdapter());
  Hive.registerAdapter<Area>(AreaAdapter());
  Hive.registerAdapter<Project>(ProjectAdapter());
  Hive.registerAdapter<Resource>(ResourceAdapter());
  Hive.registerAdapter<Task>(TaskAdapter());
  Hive.registerAdapter<TaskExecutionRecord>(TaskExecutionRecordAdapter());


  runApp(
    Phoenix(child: App())
  );
}