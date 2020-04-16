import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:zendaily/bloc/app/app_bloc.dart';
import 'package:zendaily/models/models.dart';
import 'package:zendaily/models/recurrence_type.dart';
import 'package:zendaily/utils.dart';
import 'package:zendaily/models/task.dart';
import 'package:zendaily/shared/input_field.dart';

class AddTask extends StatefulWidget {
  final formKey = GlobalKey<FormState>();
  final Project project;
  final Area area;

  AddTask({ this.project, this.area });

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final List<RecurrenceType> recurrenceOptions = [
    RecurrenceType.nonrecurring,
    RecurrenceType.daily,
    RecurrenceType.weekly,
    RecurrenceType.monthly
  ];


  String taskTitle = '';
  RecurrenceType recurrenceType = RecurrenceType.daily;

  void onFormSubmit(AppState state) {
    // ignore: close_sinks
    final AppBloc appBloc = BlocProvider.of<AppBloc>(context);
    if (taskTitle.length > 0 && recurrenceType != null) {
      Task task = Task(
          areaId: widget.area.id,
          projectId: widget.project.id,
          title: taskTitle,
          recurrenceType: recurrenceType
      );
      appBloc.add(AddTaskEvent(task: task, currentState: state));
      Navigator.of(context).pop();
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
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          NeuAppBar(
            title: Text('Add a Task', style: Theme.of(context).textTheme.headline6),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              child: Form(
                key: widget.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InputField(
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        onChanged: onTitleChange,
                        controller: _titleController,
                        decoration: InputDecoration(
                            hintText: 'Enter task title',
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Text('Select Recurrence', style: Theme.of(context).textTheme.caption,),
                    SizedBox(height: 10),
                    InputField(
                      child: DropdownButton(
                          isExpanded: true,
                          icon: Icon(FontAwesomeIcons.caretDown),
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
                    Spacer(),
                    BlocBuilder<AppBloc, AppState>(
                      bloc: BlocProvider.of<AppBloc>(context),
                      builder: (context, state)  {
                        return NeuButton(
                          onPressed: () => onFormSubmit(state),
                          child: Text('Add', style: Theme.of(context).textTheme.button),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
