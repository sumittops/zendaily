import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:zendaily/models/recurrence_type.dart';
import 'package:zendaily/models/task.dart';
import 'package:zendaily/app.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // final appDocDirectory = await path_provider.getApplicationDocumentsDirectory();
  await  Hive.initFlutter();
  Hive.registerAdapter(RecurrenceTypeAdapter());
  Hive.registerAdapter(TaskAdapter());

  runApp(App());
}