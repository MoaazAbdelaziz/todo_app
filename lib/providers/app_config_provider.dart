import 'package:flutter/material.dart';
import 'package:todo_app/cache_helper.dart';

class AppConfigProvider extends ChangeNotifier {
  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.light;

  void changeAppLanguage(String newLanguage) {
    if (newLanguage == appLanguage) {
      CacheHelper.setData(key: 'language', value: appLanguage);
      return;
    } else {
      appLanguage = newLanguage;
      CacheHelper.setData(key: 'language', value: newLanguage);
    }
    notifyListeners();
  }

  void changeAppTheme(ThemeMode newTheme) {
    if (newTheme == appTheme) {
      CacheHelper.setData(key: 'theme', value: appLanguage);
      return;
    } else {
      appTheme = newTheme;
      CacheHelper.setData(key: 'theme', value: newTheme);
    }
    notifyListeners();
  }

  dynamic getAppLanguage() {
    return CacheHelper.getData(key: 'language');
  }

  dynamic getAppTheme() {
    return CacheHelper.getData(key: 'theme');
  }
}
