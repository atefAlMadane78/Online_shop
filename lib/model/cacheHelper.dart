import 'package:shared_preferences/shared_preferences.dart';

class cacheHelper {
  static SharedPreferences? sharedpreferences;

  static init() async {
    sharedpreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedpreferences!.setString(key, value);
    if (value is int) return await sharedpreferences!.setInt(key, value);
    if (value is bool) return await sharedpreferences!.setBool(key, value);

   return await sharedpreferences!.setDouble(key, value);
  }

  static bool getBoolData(
    {
      required String key
    }
  ){
    return sharedpreferences!.getBool(key) ?? false;
  }

  static String getStringData(
    {
      required String key
    }
  ){
    return sharedpreferences!.getString(key) ?? '';
  }

  static Future<bool> removeData({
    required String key,
  })async {
    return await sharedpreferences!.remove(key);
  }
}
