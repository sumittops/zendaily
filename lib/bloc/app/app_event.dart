part of 'app_bloc.dart';

abstract class AppEvent  {
  const AppEvent();
}

class FetchAllData extends AppEvent {}

class AddTaskEvent extends AppEvent {
  Task task;
  AppState currentState;
  AddTaskEvent({
    this.task,
    this.currentState
  });
}

