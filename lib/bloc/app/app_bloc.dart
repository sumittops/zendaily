import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zendaily/models/models.dart';
import 'package:zendaily/repository/area_repository.dart';
import 'package:zendaily/repository/project_repository.dart';
import 'package:zendaily/repository/task_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {

  AreaRepository _areaRepository;
  ProjectRepository _projectRepository;
  TaskRepository _taskRepository;

  AppBloc(this._areaRepository, this._projectRepository, this._taskRepository);

  @override
  AppState get initialState => AppState();

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is FetchAllData) {
      yield AppState(areaLoading: true, projectLoading: true, taskLoading: true);
      final areas = await _areaRepository.getAll();
      final projects = await _projectRepository.getAll();
      final tasks = await _taskRepository.getAll();

      Map<String, List<Project>> areaProjectMap = {};
      projects.forEach((Project project) {
        if(!areaProjectMap.containsKey(project.areaId)) {
          areaProjectMap[project.areaId] = [];
        }
        areaProjectMap[project.areaId].add(project);
      });

      Map<String, List<Task>> projectTaskMap = {};
      tasks.forEach((Task task) {
        if(!projectTaskMap.containsKey(task.areaId)) {
          projectTaskMap[task.projectId] = [];
        }
        projectTaskMap[task.projectId].add(task);
      });

      Map<String, List<Task>> areaTaskMap = {};
      tasks.forEach((Task task) {
        if(!areaTaskMap.containsKey(task.areaId)) {
          areaTaskMap[task.areaId] = [];
        }
        areaTaskMap[task.areaId].add(task);
      });
      yield AppState(
        areaLoading: false,
        projectLoading: false,
        taskLoading: false,
        areaProjectMap: areaProjectMap,
        areaTaskMap: areaTaskMap,
        projectTaskMap: projectTaskMap,
        areas: areas,
        projects: projects,
        tasks: tasks
      );
    }
  }
}
