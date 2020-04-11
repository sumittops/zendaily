import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:zendaily/models/task.dart';

class TaskListItem extends StatelessWidget {
  final Task task;

  TaskListItem({
    this.task
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return NeuCard(
      bevel: 2,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      margin: EdgeInsets.only(bottom: 18),
      decoration: NeumorphicDecoration(
        borderRadius: BorderRadius.circular(8)
      ),
      color: Colors.grey[300],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(task.title, style: textTheme.headline6),
          SizedBox(height: 8,),
          Text(task.areaId, style: textTheme.bodyText1),
        ],
      ),
    );
  }
}