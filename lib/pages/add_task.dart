import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:zendaily/models/recurrence_type.dart';
import 'package:hive/hive.dart';
import 'package:zendaily/models/task.dart';

class AddTask extends StatefulWidget {
  final formKey = GlobalKey<FormState>();
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final List<RecurrenceType> recurrenceOptions = [
    RecurrenceType.daily,
    RecurrenceType.weekly,
    RecurrenceType.monthly
  ];
  final Map<RecurrenceType, String> recurrenceLabel = {
    RecurrenceType.daily: 'Daily',
    RecurrenceType.weekly: 'Weekly',
    RecurrenceType.monthly: 'Monthly'
  };

  String taskTitle = '';
  String taskCategory = '';
  RecurrenceType recurrenceType = RecurrenceType.daily;

  void onFormSubmit() {
    Box<Task> tasksBox = Hive.box<Task>('tasks');
    if (taskCategory.length > 0 && taskTitle.length > 0 && recurrenceType != null) {
      tasksBox.add(Task(
          category: taskCategory,
          title: taskTitle,
          recurrenceType: recurrenceType));
      Navigator.of(context).pop();
    }
  }

  void onTitleChange(String value) {
    setState(() {
      taskTitle = value;
    });
  }

  void onCategoryChange(String value) {
    setState(() {
      taskCategory = value;
    });
  }

  void onRecurrenceChange(RecurrenceType type) {
    setState(() {
      recurrenceType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Task', style: Theme.of(context).textTheme.headline6),
      ),
      body: Container(
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
                    controller: _titleController),
              ),
              NeuCard(
                  margin: EdgeInsets.only(bottom: 16),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: onCategoryChange,
                      controller: _categoryController)),
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
              FlatButton(
                onPressed: onFormSubmit,
                child: Text('Add', style: Theme.of(context).textTheme.bodyText2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
