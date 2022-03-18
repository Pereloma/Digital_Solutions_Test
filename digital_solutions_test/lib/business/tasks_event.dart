part of 'tasks_bloc.dart';

@immutable
abstract class TasksEvent {}

class DownloadTasks extends TasksEvent{
}
class AddTask extends TasksEvent{
}
class CreateTask extends TasksEvent{
  final String textTask;
  CreateTask(this.textTask);
}
class SwitchTask  extends TasksEvent{
  final int id;

  SwitchTask(this.id);

}