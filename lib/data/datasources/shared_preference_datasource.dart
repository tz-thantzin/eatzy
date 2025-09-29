import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceDatasource {
  final SharedPreferences _sharedPreferences;

  SharedPreferenceDatasource._(this._sharedPreferences);

  static Future<SharedPreferenceDatasource> init(
    SharedPreferences? sharedPreferences,
  ) async {
    final prefs = sharedPreferences ?? await SharedPreferences.getInstance();
    return SharedPreferenceDatasource._(prefs);
  }

  Future<void> saveString(String key, String value) async {
    await _sharedPreferences.setString(key, value);
  }

  Future<void> saveDouble(String key, double value) async {
    await _sharedPreferences.setDouble(key, value);
  }

  Future<void> saveInt(String key, int value) async {
    await _sharedPreferences.setInt(key, value);
  }

  Future<void> saveBool(String key, bool value) async {
    await _sharedPreferences.setBool(key, value);
  }

  String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  double? getDouble(String key) {
    return _sharedPreferences.getDouble(key);
  }

  int? getInt(String key) {
    return _sharedPreferences.getInt(key);
  }

  bool? getBool(String key) {
    return _sharedPreferences.getBool(key);
  }

  Future<void> clearAll() async {
    await _sharedPreferences.clear();
  }
}
