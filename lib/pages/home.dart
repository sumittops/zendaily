import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:zendaily/bloc/app/app_bloc.dart';
import 'package:zendaily/models/task.dart';
import 'package:zendaily/pages/task_launch.dart';


class Home extends StatelessWidget {
  void handleTaskLaunch(BuildContext context, String type) {
    Box<Task> box = Hive.box('tasks');
    final totalTasks = box.length;
    final index = Random().nextInt(totalTasks);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => TaskLaunch(task: box.getAt(index))
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.grey[300],
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.white60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Do something', style: Theme.of(context).textTheme.headline2),
                NeuButton(
                  onPressed: () {
                    handleTaskLaunch(context, 'productive');
                  },

                  child: Text('Productive', style: Theme.of(context).textTheme.button),
                ),
                Text('Or', style: Theme.of(context).textTheme.headline4,),
                NeuButton(
                  onPressed: () {
                    handleTaskLaunch(context, 'fun');
                  },
                  child: Text('Fun', style: Theme.of(context).textTheme.button),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
