import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/cache_helper.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/home/home_view.dart';
import 'package:todo_app/home/my_theme.dart';
import 'package:todo_app/home/todo/edit_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/providers/app_config_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CacheHelper.cacheInit();

  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => AppConfigProvider(),
      child: const ToDoApp(),
    ),
  );
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var lang = provider.getAppLanguage();
    var theme = provider.getAppTheme();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      routes: {
        HomeView.routeName: (context) => const HomeView(),
        EditView.routeName: (context) => const EditView(),
      },
      initialRoute: HomeView.routeName,
      locale: Locale(lang),
      themeMode: ThemeMode.light,
    );
  }
}
