import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:zendaily/models/task.dart';

class TaskExecutedListItem extends StatelessWidget {
  final Task task;

  TaskExecutedListItem({
    this.task
  });

  @override
  Widget build(BuildContext context) {
    return NeuCard(
      bevel: 2,
      color: Colors.grey[300],
    );
  }
}