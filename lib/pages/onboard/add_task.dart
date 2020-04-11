import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:zendaily/models/models.dart';
import 'package:zendaily/models/recurrence_type.dart';
import 'package:zendaily/models/task.dart';

class AddTask extends StatefulWidget {
  final formKey = GlobalKey<FormState>();
  final Area area;
  final Project project;
  final Function onCreate;
  @override
  _AddTaskState createState() => _AddTaskState();
  
  AddTask({
    @required this.area,
    @required this.project,
    @required this.onCreate
  });
  
}

class _AddTaskState extends State<AddTask> {
  final List<RecurrenceType> recurrenceOptions = [
    RecurrenceType.nonrecurring,
    RecurrenceType.daily,
    RecurrenceType.weekly,
    RecurrenceType.monthly,
  ];
  final Map<RecurrenceType, String> recurrenceLabel = {
    RecurrenceType.nonrecurring: 'One time',
    RecurrenceType.daily: 'Daily',
    RecurrenceType.weekly: 'Weekly',
    RecurrenceType.monthly: 'Monthly'
  };

  String taskTitle = '';
  RecurrenceType recurrenceType = RecurrenceType.nonrecurring;

  void onFormSubmit() {
    if (taskTitle.length > 0 && recurrenceType != null) {
      final newTask = Task(
          areaId: widget.area.id,
          projectId: widget.project.id,
          title: taskTitle,
          recurrenceType: recurrenceType
      );
      widget.onCreate(newTask);
    }
  }

  void onTitleChange(String value) {
    setState(() {
      taskTitle = value;
    });
  }

  void onRecurrenceChange(RecurrenceType type) {
    setState(() {
      recurrenceType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 18),
        child: Form(
          key: widget.formKey,
          child: Column(
            children: <Widget>[
              NeuCard(
                  margin: EdgeInsets.only(bottom: 16),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    onChanged: onTitleChange,
                  ),
              ),
              NeuCard(
                margin: EdgeInsets.only(bottom: 16),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: DropdownButton(
                        isExpanded: true,
                        value: recurrenceType,
                        hint: Text('Select Recurrence',
                            style: Theme.of(context).textTheme.bodyText2),
                        items: recurrenceOptions.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              recurrenceLabel[item],
                              style: Theme.of(context).textTheme.bodyText2
                            ),
                          );
                        }).toList(),
                        onChanged: onRecurrenceChange
                      ),
                    ),
                  ],
                ),
              ),
              NeuButton(
                onPressed: onFormSubmit,
                child: Text('Add', style: Theme.of(context).textTheme.bodyText2),
              ),
            ],
          ),
        ),
    );
  }
}
