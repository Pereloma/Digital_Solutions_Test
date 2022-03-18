import 'package:digital_solutions_test/model/task.dart';
import 'package:digital_solutions_test/business/tasks_bloc.dart';
import 'package:digital_solutions_test/business/tasks_repository.dart';
import 'package:digital_solutions_test/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksBloc(TasksRepository.createRepository()),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 32, 32, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Tasks", style: TextStyles.header),
                      _AddButton(),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(64, 0, 64, 16),
                  child: Divider(),
                ),

                const Flexible(child: _TasksList())
                //ListView.builder(itemBuilder: itemBuilder)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      width: 56,
      height: 56,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
          side: BorderSide(
              color: isDark ? const Color(0xFF29292F) : const Color(0xFFEBEBEB),
              width: 1),
        ),
        color: isDark ? const Color(0xFF24242D) : const Color(0xFFF2F3FF),
        child: InkWell(
          onTap: () => BlocProvider.of<TasksBloc>(context).add(AddTask()),
          child: SvgPicture.asset(
            "assets/NewTaskButton.svg",
            fit: BoxFit.scaleDown,
            height: 24,
            width: 24,
            color: const Color(0xFF575767),
          ),
        ),
      ),
    );
  }
}

class _TasksList extends StatelessWidget {
  const _TasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(64, 0, 64, 0),
          child: Column(
            children: [
              if (state.runtimeType == TasksCreate) const _Task.create(),
              Flexible(
                child: ListView.builder(
                  key: GlobalKeys.tasksList,
                  itemCount: state.taskList.length,
                  itemBuilder: (context, index) {
                    return _Task(task: state.taskList[index]);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Task extends StatelessWidget {
  const _Task({Key? key, required this.task}) : super(key: key);

  const _Task.create({Key? key})
      : task = null,
        super(key: key);
  final Task? task;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: task != null?() => BlocProvider.of<TasksBloc>(context).add(SwitchTask(task!.key)):null,
        child: Row(
          children: [
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: isDark
                          ? const Color(0xFF0E0E11)
                          : const Color(0xFFDADADA),
                      width: 2),
                  borderRadius: BorderRadius.circular(6.0),
                  gradient: LinearGradient(
                    colors: [
                      isDark
                          ? const Color(0xFF2B2D37)
                          : const Color(0xFFFCFCFC),
                      isDark ? const Color(0xFF262933) : const Color(0xFFF8F8F8)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
              child: task?.isDone ?? false
                  ? SvgPicture.asset("assets/Complete.svg",
                      color: isDark
                          ? const Color(0xFFDADADA)
                          : const Color(0xFF575767))
                  : null,
            ),
            const SizedBox(height: 10, width: 10),
            if (task == null)
              Flexible(
                  child: TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'new task',
                ),
                onSubmitted: (text) =>
                    BlocProvider.of<TasksBloc>(context).add(CreateTask(text)),
              ))
            else
              Text(task!.taskText, style: TextStyles.task)
          ],
        ),
      ),
    );
  }
}
