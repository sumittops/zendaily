import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:zendaily/pages/add_task.dart';
import 'package:zendaily/models/task.dart';
import 'package:zendaily/animations/fade_in.dart';
import 'package:zendaily/shared/task_list_item.dart';


class TasksPage extends StatelessWidget {
  final String title;

  TasksPage({this.title});

  Widget _buildList() {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Task>('tasks').listenable(),
      builder: (BuildContext context, Box<Task> tasksBox, _) {
        if (tasksBox.values.isEmpty) {
          return NeuCard(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 32),
            child: Center(
              child: Text('No Tasks', style: Theme.of(context).textTheme.bodyText1),
            ),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            Task task = tasksBox.getAt(index);
            return FadeInTransition(
              child: TaskListItem(task: task)
            );
          },
          itemCount: tasksBox.length,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size dimens = MediaQuery.of(context).size;
    return SafeArea(
        child: Container(
      height: dimens.height - 150,
      width: double.infinity,
      color: Colors.grey[300],
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              NeuCard(
                curveType: CurveType.concave,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 32, horizontal: 14),
                margin: EdgeInsets.only(bottom: 24),
                decoration: NeumorphicDecoration(
                    borderRadius: BorderRadius.circular(12)),
                child:
                    Text(title, style: Theme.of(context).textTheme.headline4),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: _buildList())
            ],
          ),
          Positioned(
            right: 20,
            bottom: 120,
            child: Container(
              height: 54,
              width: 54,
              margin: EdgeInsets.only(right: 12),
              child: NeuButton(
                shape: BoxShape.circle,
                onPressed: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddTask()
                    ) 
                  )
                },
                child: Center(child: Icon(FontAwesomeIcons.plusCircle, color: Colors.grey,)),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
