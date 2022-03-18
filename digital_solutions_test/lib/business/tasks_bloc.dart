import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:digital_solutions_test/model/task.dart';
import 'package:digital_solutions_test/business/tasks_repository.dart';
import 'package:meta/meta.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  late final TasksRepository _tasksRepository;
  TasksBloc(Future<TasksRepository> tasksRepository) : super(const TasksInitial()) {
    on<AddTask>((event, emit) {
      emit(TasksCreate(_tasksRepository.getTasks()));
    });
    on<CreateTask>((event, emit) {
      if(event.textTask.isNotEmpty){
        _tasksRepository.addTask(Task(isDone: false,taskText: event.textTask));
      }
        emit(TasksLoaded(_tasksRepository.getTasks()));
    });
    on<DownloadTasks>((event, emit) {
      emit(TasksLoaded(_tasksRepository.getTasks()));
    });
    on<SwitchTask>((event, emit) {
      _tasksRepository.switchTask(event.id);
      emit(TasksLoaded(_tasksRepository.getTasks()));
    });

    setTasksRepository(tasksRepository);
  }
  setTasksRepository(Future<TasksRepository> tasksRepository)async{
    _tasksRepository = await tasksRepository;
    add(DownloadTasks());
  }
  @override
  Future<void> close() {
    _tasksRepository.close();
    return super.close();
  }
}
