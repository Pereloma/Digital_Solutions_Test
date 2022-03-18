import 'package:digital_solutions_test/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

import 'model/task.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData(
          brightness: Brightness.light,
          cardColor: const Color(0xFFFFFFFF),
          scaffoldBackgroundColor: const Color(0xFFE5E5E5)
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          cardColor: const Color(0xFF1E1F25),
          scaffoldBackgroundColor: const Color(0xFF000000)
      ),
      home: const Home(),
    );
  }
}
