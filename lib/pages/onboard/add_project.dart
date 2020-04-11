import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:zendaily/models/area.dart';
import 'package:zendaily/models/models.dart';

class AddProject extends StatefulWidget {
  final Area area;
  final Function onCreate;
  @override
  _AddProjectState createState() => _AddProjectState();
  AddProject({ 
    @required this.area,
    @required this.onCreate
  });
}

class _AddProjectState extends State<AddProject> {
  String name;
  String description;
  DateTime deadlineDate = DateTime.now();
  TextEditingController _deadlineFieldController = TextEditingController();
  
  void selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: deadlineDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030)
    );
    if (picked != null && picked != deadlineDate) {
      setState(() {
        deadlineDate = picked;
      });
      _deadlineFieldController.text = picked.toLocal().toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Project Name'
            ),
            onChanged: (value) {
              setState(() {
                name = value;
              });
            },
          ),
          SizedBox(
            height: 40,
          ),
          TextField(
            maxLines: 2,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: 'Add a description (optional)'
            ),
            onChanged: (value) {
              setState(() {
                description = value;
              });
            },
          ),
          SizedBox(
            height: 40,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Add deadline'
            ),
            onTap: () => selectDate(context),
            controller: _deadlineFieldController,
          ),
          SizedBox(
            height: 40,
          ),
          NeuButton(
            child: Text('Create Project'),
            onPressed: () => {
              widget.onCreate(
                Project(
                  areaId: widget.area.id, 
                  deadline: deadlineDate,
                  name: name,
                  description: description
                )
              )
            },
          )
        ],
      ),
    );
  }
}