
import 'package:flutter/material.dart';

import 'models/recurrence_type.dart';

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
const String BOX_TYPE_RESOURCE = 'resources';
const String BOX_TYPE_TASK = 'tasks';
const String BOX_TYPE_TASK_EXECUTION = 'task_execution';

List<int> areaColors = [
  Colors.blue.value,
  Colors.red.value,
  Colors.green.value,
  Colors.amber.value,
  Colors.purple.value,
  Colors.yellow.value,
  Colors.pink.value,
];

final Map<RecurrenceType, String> recurrenceLabel = {
  RecurrenceType.nonrecurring: 'One time',
  RecurrenceType.daily: 'Daily',
  RecurrenceType.weekly: 'Weekly',
  RecurrenceType.monthly: 'Monthly'
};
