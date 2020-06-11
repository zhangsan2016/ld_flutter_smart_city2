import 'package:shared_preferences/shared_preferences.dart';

///数据库相关的工具
class SharedPreferenceUtil {
  static final String LOGIN_INFO = "loginInfo";

  static   Future<Object> set(String str, String setStr) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(str, setStr);
  }

  static Future<Object> del(String str) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(str);
  }

  static Future<Object> get(String str) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String counter = prefs.getString(str);
    // print('------获得结果 $counter-----');
    return counter;
  }

  sharedAddAndUpdate(String key, Object dataType, Object data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    switch (dataType) {
      case bool:
        sharedPreferences.setBool(key, data);
        break;
      case double:
        sharedPreferences.setDouble(key, data);
        break;
      case int:
        sharedPreferences.setInt(key, data);
        break;
      case String:
        sharedPreferences.setString(key, data);
        break;
      case List:
        sharedPreferences.setStringList(key, data);
        break;
      default:
        sharedPreferences.setString(key, data.toString());
        break;
    }
  }
}
