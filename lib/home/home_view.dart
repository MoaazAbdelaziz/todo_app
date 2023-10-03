import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/home/my_theme.dart';
import 'package:todo_app/home/settings/settings_tab.dart';
import 'package:todo_app/home/todo/add_task_bottom_sheet.dart';
import 'package:todo_app/home/todo/todo_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/login/login_screen.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:todo_app/providers/auth_provider.dart';
import 'package:todo_app/providers/task_list_provider.dart';

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
    var provider = Provider.of<AppConfigProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context);
    var listProvider = Provider.of<TaskListProvider>(context);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: Text(
          provider.appLanguage == 'en'
              ? enTitles[currentIndex]
              : arTitles[currentIndex],
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              listProvider.tasks = [];
              authProvider.currentUser = null;
              Navigator.pushNamed(context, LoginScreen.routeName);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
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
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.list),
              label: AppLocalizations.of(context)!.list,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: AppLocalizations.of(context)!.settings,
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

  List<String> enTitles = [
    'To Do List',
    'Settings',
  ];

  List<String> arTitles = [
    'قائمة المهام',
    'الاعدادات',
  ];

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const AddTaskBottomSheet(),
    );
  }
}
