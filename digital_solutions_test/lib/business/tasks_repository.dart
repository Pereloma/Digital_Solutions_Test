import 'package:digital_solutions_test/model/task.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TasksRepository{
  static const String _boxName = "Tasks";
  final Box<Task> _box;

  TasksRepository._(this._box);

  List<Task> getTasks(){
    List<Task> taskList = _box.values.toList()..sort((a, b) => a.key>b.key? 0:1);

    return taskList;
  }

  Future<void> addTask(Task task){

    return _box.add(task);
  }

  Future<void> switchTask(int id){
    Task task = _box.get(id)!;
    task.switchDone();
    return task.save();
  }

  static Future<TasksRepository> createRepository() async{
    Box<Task> newBox = await Hive.openBox<Task>(_boxName);
    return TasksRepository._(newBox);
  }

  close(){
    _box.close();
  }
}

