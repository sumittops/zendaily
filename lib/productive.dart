import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:zendaily/models/task.dart';

class Productive extends StatelessWidget {
  final List<Task> tasks = [
    Task(
        title: 'Workout - Calisthenics',
        category: 'Habit forming',
        recurrenceType: RecurrenceType.daily),
    Task(
        title: 'Take out the trash',
        category: 'Chore',
        recurrenceType: RecurrenceType.daily),
    Task(
        title: 'Read journal on Mobile markets',
        category: 'Research',
        recurrenceType: RecurrenceType.daily)
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        color: Colors.grey[300],
        child: Column(
          children: <Widget>[
            NeuCard(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 32, horizontal: 14),
              margin: EdgeInsets.only(bottom: 24),
              decoration:
                  NeumorphicDecoration(borderRadius: BorderRadius.circular(12)),
              child: Text('Productive',
                  style: Theme.of(context).textTheme.headline4),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                Task task = tasks[index];
                return NeuCard(
                  bevel: 6,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  margin: EdgeInsets.only(bottom: 32, left: 16, right: 16),
                  decoration: NeumorphicDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        task.title,
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize: 18
                        ),
                      ),
                      Text(task.category, style: Theme.of(context).textTheme.bodyText2,)
                    ],
                  ),
                );
              },
              itemCount: tasks.length,
            ),
          ],
        ),
      ),
    );
  }
}
