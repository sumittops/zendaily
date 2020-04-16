part of 'app_bloc.dart';

 class AppState extends Equatable {
  final Iterable<Area> areas;
  final Iterable<Project> projects;
  final Iterable<Task> tasks;
  final Map<String, List<Task>> projectTaskMap;
  final Map<String, List<Project>> areaProjectMap;
  final Map<String, List<Task>> areaTaskMap;

  final bool areaLoading;
  final bool projectLoading;
  final bool taskLoading;
  final bool error;

  AppState({
    this.areas = const {},
    this.projects  = const {}, 
    this.tasks = const {},
    this.error = false,
    this.areaLoading = false,
    this.projectLoading = false,
    this.taskLoading = false,
    this.areaProjectMap = const {},
    this.projectTaskMap = const {},
    this.areaTaskMap = const {}
  });

  @override
  List<Object> get props => [
    areas, projects, tasks, error, areaLoading, taskLoading, projectLoading, areaProjectMap, projectTaskMap, areaTaskMap
  ];

}
