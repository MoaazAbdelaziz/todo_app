import 'package:flutter/material.dart';
import 'package:todo_app/home/home_view.dart';
import 'package:todo_app/home/my_theme.dart';
import 'package:todo_app/home/todo/edit_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: MyTheme.lightTheme,
      routes: {
        HomeView.routeName: (context) => const HomeView(),
        EditView.routeName: (context) => const EditView(),
      },
      initialRoute: HomeView.routeName,
      locale: const Locale('ar'),
    );
  }
}
