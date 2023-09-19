import 'package:shared_preferences/shared_preferences.dart';

abstract class CacheHelper {
  static late SharedPreferences preferences;

  static cacheInit() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData(
      {required String key, required dynamic value}) async {
    if (value is int) {
      await preferences.setInt(key, value);
      return true;
    }
    if (value is String) {
      await preferences.setString(key, value);
      return true;
    }
    if (value is bool) {
      await preferences.setBool(key, value);
      return true;
    }
    if (value is double) {
      await preferences.setDouble(key, value);
      return true;
    }
    return false;
  }

  static dynamic getData({required String key}) {
    return preferences.get(key);
  }

  static void removeDataWithKey({required String key}) {
    preferences.remove(key);
  }
}
