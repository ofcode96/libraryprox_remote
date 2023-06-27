import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrencesServices {
  static SharedPreferences? _prefrences;

  static Future<SharedPreferences> get preferences async {
    _prefrences ??= await SharedPreferences.getInstance();
    return _prefrences!;
  }

  static Future<void> storeData(String key, dynamic value) async {
    final prefes = await preferences;

    switch (value.runtimeType) {
      case int:
        prefes.setInt(key, value);
        break;
      case String:
        prefes.setString(key, value);
        break;
      case bool:
        prefes.setBool(key, value);
        break;
      case double:
        prefes.setDouble(key, value);
        break;
      case <String>[]:
        prefes.setStringList(key, value);
        break;
      default:
        return;
    }
  }

  static Future getData<T>(String key) async {
    final prefes = await preferences;

    switch (T) {
      case int:
        return prefes.getInt(key);
      case String:
        return prefes.getString(key);
      case bool:
        return prefes.getBool(key);
      case double:
        return prefes.getDouble(key);
      case <String>[]:
        return prefes.getStringList(key);
      default:
        return;
    }
  }

  static Future<bool> clear() async {
    final prefs = await preferences;
    return prefs.clear();
  }
}
