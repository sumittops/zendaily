import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:zendaily/models/task.dart';
import 'package:zendaily/models/task_execution_record.dart';
import 'package:zendaily/utils.dart';

class TaskRunner extends StatefulWidget {
  final Task task;
  TaskRunner(this.task);

  @override
  _TaskRunnerState createState() => _TaskRunnerState();
}

class _TaskRunnerState extends State<TaskRunner>
    with SingleTickerProviderStateMixin {
  Timer _timer;
  int _seconds = 0;
  TaskExecutionRecord executionRecord;
  bool taskDone = false;

  @override
  void initState() {
    super.initState();
    executionRecord = TaskExecutionRecord(
      startTime: DateTime.now(),
      taskId: widget.task.id
    );
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

  void stopTimer() {
    _timer.cancel();
  }

  void showResult() {
    setState(() {
      taskDone = true;
    });
  }

  void handleDone() {
    Box<TaskExecutionRecord> box = Hive.box('task_execution');
    executionRecord.endTime = DateTime.now();
    box.add(executionRecord);
    stopTimer();
    showResult();
  }

  Widget _buildTimer(BuildContext context) {
    final timePassed = Duration(seconds: _seconds);
    final textTheme = Theme.of(context).textTheme;
    final timeInHMS = getDurationInHMS(timePassed);
    final List<String> timeParts = timeInHMS.split(':');
    return NeuCard(
      bevel: 4,
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: NeumorphicDecoration(borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            timeParts[0],
            style: textTheme.headline4,
          ),
          Text(' : ',
              textAlign: TextAlign.center, style: textTheme.headline5),
          Text(
            timeParts[1],
            style: textTheme.headline4,
          ),
          Text(' : ',
              textAlign: TextAlign.center, style: textTheme.headline5),
          Text(
            timeParts[2],
            style: textTheme.headline4,
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return NeuCard(
      bevel: 4,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(12),
      decoration: NeumorphicDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('You\'ve just finished doing', style: textTheme.bodyText1),
          SizedBox(
            height: 6,
          ),
          Text(widget.task.title, style: textTheme.headline5),
          SizedBox(
            height: 6,
          ),
          Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.task.areaId),
                Column(
                  children: <Widget>[
                    Text('Time spent', style: textTheme.bodyText1),
                    SizedBox(
                      height: 6,
                    ),
                    Text(getDurationInHMS(executionRecord.duration),
                        style: textTheme.headline6)
                  ],
                ),
              ]),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final contentList = taskDone ? [
      _buildResultCard(context)
    ] : [
      _buildTimer(context),
      Flexible(
        flex: 1,
        child: Center(
          child: SizedBox(
            height: 44,
            child: NeuButton(
              onPressed: handleDone,
              child: Text('Done for now'),
            ),
          ),
        ),
      )
    ];
    return Scaffold(
      appBar: NeuAppBar(
        title: Text(
          widget.task.title,
          style: textTheme.headline5,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: contentList
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
