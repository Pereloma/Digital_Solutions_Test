import 'package:hive_flutter/hive_flutter.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject{

  @HiveField(1)
  bool isDone;
  @HiveField(2)
  String taskText;

  Task({required this.isDone, required this.taskText});


  switchDone(){
    isDone = !isDone;
  }
}