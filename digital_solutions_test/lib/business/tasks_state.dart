part of 'tasks_bloc.dart';

@immutable
abstract class TasksState {
  final List<Task> taskList;

  const TasksState(this.taskList);
}
class TasksInitial extends TasksState {
  const TasksInitial() : super(const<Task>[]);
}
class TasksLoaded extends TasksState {
  const TasksLoaded(List<Task> taskList) : super(taskList);
}

class TasksCreate extends TasksState {
  const TasksCreate(List<Task> taskList) : super(taskList);

}