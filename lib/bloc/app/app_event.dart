part of 'app_bloc.dart';

abstract class AppEvent  {
  const AppEvent();
}

class FetchAllData extends AppEvent {}

class FetchAreaLoadedEvent extends AppEvent {
  final List<Area> areas;
  FetchAreaLoadedEvent({
    this.areas
  });
}

class FetchProjectsLoadedEvent extends AppEvent {
  final List<Project> projects;
  FetchProjectsLoadedEvent({ this.projects });
}

class FetchTasksLoadedEvent extends AppEvent {
  final List<Task> tasks;

  FetchTasksLoadedEvent({
    this.tasks
  });

}


