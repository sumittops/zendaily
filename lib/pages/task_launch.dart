import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:zendaily/animations/fade_in.dart';
import 'package:zendaily/models/task.dart';
import 'package:zendaily/pages/task_runner.dart';
import 'package:zendaily/utils.dart';


class TaskLaunch extends StatelessWidget {
  final Task task;
  final Duration _animationDuration = Duration(milliseconds: 500);
  final double _offset = 100;

  TaskLaunch({ this.task });

  Widget _buildTaskCard(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return FadeInTransition(
      duration: _animationDuration,
      distance: _offset,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(task.title, style: textTheme.headline5),
                    SizedBox(height: 10),
                    Text(recurrenceLabel[task.recurrenceType], style: textTheme.bodyText1),
                    SizedBox(height: 10),
                    Text(task.areaId, style: textTheme.bodyText1),
                ]
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                children: [
                    Text('78%', style: textTheme.headline4),
                    SizedBox(height: 10),
                    Text('Consistency', style: textTheme.caption),
                ]
              ),
            ),
          ]
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: NeuAppBar(
        title: Text('Ready to Launch', style: textTheme.headline6,),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
            _buildTaskCard(context),
            SizedBox(height: 120),
            FadeInTransition(
              distance: _offset,
              duration: _animationDuration,
              child: SizedBox(
                height: 150,
                child: Center(
                  child: NeuButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TaskRunner(task)
                        )
                      );
                    },
                    child: Icon(FontAwesomeIcons.play, size: 64, color: Colors.grey,),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            SizedBox(height: 60,),
            FadeInTransition(
              distance: _offset,
              duration: _animationDuration,
              child: SizedBox(
                height: 60,
                child: NeuButton(
                  onPressed: () => null,
                  child: Text('Do something else', style: textTheme.bodyText2,),
                )
              ),
            )
          ],
        ),
      ),
    );   
  } 
}