import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static save(String key, String value) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(key, value);
  }

  static Future<String?> get(String key) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(key) &&
        sharedPreferences.getString(key) != null) {
      return sharedPreferences.getString(key);
    }
    return null;
  }

  static Future<bool?> delete(String key) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(key) &&
        sharedPreferences.getString(key) != null) {
      return sharedPreferences.remove(key);
    }
    return null;
  }
}
