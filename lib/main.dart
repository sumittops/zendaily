import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zendaily/models/models.dart';
import 'package:zendaily/app.dart';
import 'package:zendaily/utils.dart';


void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<RecurrenceType>(RecurrenceTypeAdapter());
  Hive.registerAdapter<Area>(AreaAdapter());
  Hive.registerAdapter<Project>(ProjectAdapter());
  Hive.registerAdapter<Resource>(ResourceAdapter());
  Hive.registerAdapter<Task>(TaskAdapter());
  Hive.registerAdapter<TaskExecutionRecord>(TaskExecutionRecordAdapter());
  List<Box> boxes = await _getBoxFutures();
  runApp(
    Phoenix(
      child: App(
        areaBox: boxes[0],
        projectBox: boxes[1],
        taskBox: boxes[2],
        resourceBox: boxes[3],
        taskExecBox: boxes[4],
    ))
  );
}

Future<List<Box>> _getBoxFutures() {
    return Future.wait([
      Hive.openBox<Area>(BOX_TYPE_AREA),
      Hive.openBox<Project>(BOX_TYPE_PROJECT),
      Hive.openBox<Task>(BOX_TYPE_TASK),
      Hive.openBox<Resource>(BOX_TYPE_RESOURCE),
      Hive.openBox<TaskExecutionRecord>(BOX_TYPE_TASK_EXECUTION)
    ]);
  }