import 'package:flutter/material.dart';
import 'package:todo_app/home/my_theme.dart';
import 'package:todo_app/home/settings/settings_tab.dart';
import 'package:todo_app/home/todo/add_task_bottom_sheet.dart';
import 'package:todo_app/home/todo/todo_tab.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static String routeName = 'Home-View';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: Text(
          titles[currentIndex],
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskBottomSheet();
        },
        shape: StadiumBorder(
            side: BorderSide(
          width: 6,
          color: MyTheme.whitColor,
        )),
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: tabs[currentIndex],
    );
  }

  List<Widget> tabs = const [
    TodoTab(),
    SettingsTab(),
  ];

  List<String> titles = [
    'To Do List',
    'Settings',
  ];

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const AddTaskBottomSheet(),
    );
  }
}
