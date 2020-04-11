import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:zendaily/models/models.dart';
import 'package:zendaily/pages/onboard/add_project.dart';
import 'package:zendaily/pages/onboard/add_task.dart';
import 'package:zendaily/utils.dart';


class Onboard extends StatefulWidget {
  @override
  _OnboardState createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int step = 0;
  String chosenAreaName;
  Area chosenArea;
  Project chosenProject;
  Box<Area> areaBox;
  Box<Project> projectBox;
  Box<Task> taskBox;
  final availableAreaObjs = availableAreas.map((areaname) => Area(name: areaname)).toList();


  @override
  void initState() {
    areaBox = Hive.box(BOX_TYPE_AREA);
    projectBox = Hive.box(BOX_TYPE_PROJECT);
    taskBox = Hive.box(BOX_TYPE_TASK);
    int initStep = 0;
    if (areaBox.isNotEmpty) {
      initStep++;
    }
    if (projectBox.isNotEmpty) {
      initStep++;
    }

    
    if (areaBox.isEmpty) {
      availableAreaObjs.forEach((area) {
        areaBox.put(area.id, area);
      });
    }
    if (initStep > step) {
      setState(() {
        step = initStep;
      });
    } 
    
    super.initState();
  }

  void moveToNext([dynamic data]) {
    if (step == 0) {
      areaBox.put(chosenArea.id, chosenArea);
    } else if (step == 1) {
      chosenProject = data;
      projectBox.put(data.id, data);
    } else if (step == 2) {
      taskBox.put(data.id, data);
    }
    setState(() {
      step++;
    });
  }

  Widget _buildAreaSelector(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final listTiles = availableAreaObjs.map((e) => ListTile(
      dense: true,
      key: Key(e.name),
      title: Text(e.name, style: textTheme.bodyText2),
      leading: Radio(
        groupValue: chosenArea,
        value: e,
        onChanged: (value) {
          setState(() {
            chosenArea = e;
          });
        },
      ),
    )).toList();
    return Center(
      child: Column(
        children: [
          ListView(
            shrinkWrap: true,
            children: listTiles,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: NeuButton(
            onPressed: moveToNext,
            child: Text('Next'),
          ),
        )
       ]
      ),
    );
  }

  Widget _buildOnboardingDone(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      child: Column(
        children: [
          NeuCard(
            padding: EdgeInsets.all(20),
            child: Text('You are all set!', style: textTheme.headline4),
          ),
          SizedBox(
            height: 40,
          ),
          NeuButton(
            child: Text('Awesome!'),
            onPressed: () {
              Phoenix.rebirth(context);
            },
          )
        ],
      ),
    );
  }
  
  Widget _getBody(BuildContext context) {
    switch(step) {
      case 0: 
        return _buildAreaSelector(context);
      case 1: 
        return AddProject(
          area: chosenArea,
          onCreate: moveToNext,
        );
      case 2:
        return AddTask(
          area: chosenArea,
          project: chosenProject,
          onCreate: moveToNext,
        );
      case 3:
        return _buildOnboardingDone(context);
    }
    return Container();
  }

  Widget _getHeader(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    String titleText = '';
    switch(step) {
      case 0: 
        titleText = 'Choose an Area';
        break;
      case 1: 
        titleText = 'Add a project to ${chosenArea.name}';
        break;
      case 2: 
        titleText = 'Add a task to ${chosenProject.name}';
        break;
      
    }
    return NeuCard(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: Text(titleText, style: textTheme.headline6),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
             _getHeader(context),
            _getBody(context),
          ],
        ),
      ),
    );
  }
}