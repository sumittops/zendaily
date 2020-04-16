import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:zendaily/animations/fade_in.dart';
import 'package:zendaily/bloc/app/app_bloc.dart';
import 'package:zendaily/models/models.dart';
import 'package:zendaily/pages/add_task.dart';
import 'package:zendaily/pages/task_launch.dart';
import 'package:zendaily/repository/irepository.dart';
import 'package:zendaily/shared/add_item.dart';

class ProjectPage extends StatelessWidget {
  final Project project;

  ProjectPage({
    @required this.project
  });

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    AppBloc bloc = BlocProvider.of<AppBloc>(context);
    return SafeArea(
      child: Container(
        color: Colors.white60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            NeuAppBar(
                title: Text(project.name),
            ),
            BlocBuilder(
              bloc: bloc,
              builder: (context, AppState state) {
                if (state.areaLoading || state.projectLoading || state.taskLoading) {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                final tasks = state.projectTaskMap[project.id];
                return Flexible(
                  fit: FlexFit.tight,
                  child: ListView.builder(
                    itemCount: tasks.length + 1,
                    shrinkWrap: true,
                    itemBuilder: (context, idx) {
                      if (idx < tasks.length) {
                        Task task = tasks[idx];
                        return FadeInTransition(
                          key: Key(task.id),
                          child: ListTile(
                            leading: Checkbox(
                              onChanged: null,
                              value: false,
                            ),
                            title: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: Text(task.title, style: Theme.of(context).textTheme.bodyText2,),
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => TaskLaunch(
                                          task: task,
                                        )
                                    )
                                );
                              },
                              child: Container(
                                width: 84,
                                color: Colors.grey[200],
                                padding: EdgeInsets.all(6),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Launch', style: Theme.of(context).textTheme.button,),
                                    Icon(FontAwesomeIcons.play, color: Colors.grey[400], size: 14,),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return FadeInTransition(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                          child: AddItem(
                            label: 'Add a task',
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => AddTask(
                                    project: project,
                                    area: state.areas.firstWhere((element) => element.id == project.areaId),
                                  )
                                )
                              );
                            },
                          ),
                        ),
                      );
                    }
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
