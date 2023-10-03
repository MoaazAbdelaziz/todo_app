import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/home/my_theme.dart';
import 'package:todo_app/home/todo/task_item.dart';
import 'package:todo_app/providers/auth_provider.dart';
import 'package:todo_app/providers/task_list_provider.dart';

class TodoTab extends StatefulWidget {
  const TodoTab({super.key});

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TaskListProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context);
    if (provider.tasks.isEmpty) {
      provider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
    }

    return Column(
      children: [
        CalendarTimeline(
          initialDate: provider.selectdDate,
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDateSelected: (date) {
            provider.setNewSelectedDate(date, authProvider.currentUser!.id!);
          },
          leftMargin: 20,
          monthColor: MyTheme.blackColor,
          dayColor: MyTheme.blackColor,
          activeDayColor: MyTheme.whitColor,
          activeBackgroundDayColor: Theme.of(context).primaryColor,
          dotsColor: MyTheme.whitColor,
          selectableDayPredicate: (date) => true,
          locale: 'en_ISO',
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) =>
                TaskItem(task: provider.tasks[index]),
            itemCount: provider.tasks.length,
          ),
        ),
      ],
    );
  }
}
