import 'package:shared_preferences/shared_preferences.dart';

class Sp {
  Sp._() {
    _h = this;
  }
  static Sp? _h;

  factory Sp() {
    return _h ??= Sp._();
  }

  /// save
  Future saveString(String key, String value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(key, value);
  }

  Future saveInt(String key, int value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt(key, value);
  }

  Future saveDouble(String key, double value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setDouble(key, value);
  }

  Future saveBoolean(String key, bool value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool(key, value);
  }

  Future saveStringList(String key, List<String> list) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setStringList(key, list);
  }

  /// get
  Future<String?> getString(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }

  Future<int?> getInt(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getInt(key);
  }

  Future<double?> getDouble(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getDouble(key);
  }

  Future<bool?> getBoolean(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool(key);
  }

  Future<List<String>?> getStringList(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getStringList(key);
  }
}
