import 'package:flutter/material.dart';
import 'package:todo_app/home/home_view.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeView.routeName: (context) => const HomeView(),
      },
      initialRoute: HomeView.routeName,
    );
  }
}
