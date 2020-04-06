import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:zendaily/models/task.dart';

class TaskRunner extends StatefulWidget {
  final Task task;
  TaskRunner(this.task);

  @override
  _TaskRunnerState createState() => _TaskRunnerState();
}

class _TaskRunnerState extends State<TaskRunner>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Timer _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        _seconds += 1;
      });
    });
  }

  Widget _buildTimer(BuildContext context) {
    final timePassed = Duration(seconds: _seconds);
    final textTheme = Theme.of(context).textTheme;
    return NeuCard(
      bevel: 4,
      margin: EdgeInsets.all(12),
      decoration: NeumorphicDecoration(borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 64,
            child: Text(
              '${timePassed.inHours}',
              style: textTheme.headline4,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 64,
            child: Text(
              '${timePassed.inMinutes}',
              style: textTheme.headline4,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 64,
            child: Text(
              '${timePassed.inSeconds}',
              style: textTheme.headline4,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.task.title,
            style: textTheme.headline5,
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              _buildTimer(context)
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
