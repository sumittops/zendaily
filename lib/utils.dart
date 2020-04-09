import 'package:zendaily/models/area.dart';
import 'package:zendaily/models/project.dart';
import 'package:zendaily/models/task.dart';
import 'package:zendaily/models/task_execution_record.dart';

String toTwoDigits(int n) {
  if (n >= 10) {
    return '$n';
  }
  return '0$n';
}

String getDurationInHMS(Duration duration) {
  return '${toTwoDigits(duration.inHours)}:${toTwoDigits(duration.inMinutes.remainder(60))}:${toTwoDigits(duration.inSeconds.remainder(60))}';
}

const String BOX_TYPE_AREA = 'areas';
const String BOX_TYPE_PROJECT = 'projects';
const String BOX_TYPE_TASK = 'tasks';
const String BOX_TYPE_TASK_EXECUTION = 'task_execution';