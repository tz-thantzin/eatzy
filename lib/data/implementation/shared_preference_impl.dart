import 'package:eatzy/data/datasources/shared_preference_datasource.dart';
import 'package:eatzy/domain/repositories/shared_preference_repository.dart';

import '../../domain/exceptions/local_data_storage_exception.dart';

class SharedPreferenceImpl implements SharedPreferenceRepository {
  final SharedPreferenceDatasource _datasource;

  SharedPreferenceImpl(this._datasource);

  @override
  Future<void> saveString(String key, String value) async {
    try {
      await _datasource.saveString(key, value);
    } catch (e) {
      throw SharedPreferenceSaveFailure("Failed to save string for key: $key");
    }
  }

  @override
  Future<void> saveDouble(String key, double value) async {
    try {
      await _datasource.saveDouble(key, value);
    } catch (e) {
      throw SharedPreferenceSaveFailure("Failed to save double for key: $key");
    }
  }

  @override
  Future<void> saveInt(String key, int value) async {
    try {
      await _datasource.saveInt(key, value);
    } catch (e) {
      throw SharedPreferenceSaveFailure("Failed to save int for key: $key");
    }
  }

  @override
  Future<void> saveBool(String key, bool value) async {
    try {
      await _datasource.saveBool(key, value);
    } catch (e) {
      throw SharedPreferenceSaveFailure("Failed to save bool for key: $key");
    }
  }

  @override
  Future<String?> getString(String key) async {
    try {
      final value = _datasource.getString(key);
      return value;
    } catch (e) {
      throw SharedPreferenceReadFailure("Failed to read string for key: $key");
    }
  }

  @override
  Future<double?> getDouble(String key) async {
    try {
      final value = _datasource.getDouble(key);
      return value;
    } catch (e) {
      throw SharedPreferenceReadFailure("Failed to read double for key: $key");
    }
  }

  @override
  Future<int?> getInt(String key) async {
    try {
      final value = _datasource.getInt(key);
      return value;
    } catch (e) {
      throw SharedPreferenceReadFailure("Failed to read int for key: $key");
    }
  }

  @override
  Future<bool?> getBool(String key) async {
    try {
      final value = _datasource.getBool(key);
      return value;
    } catch (e) {
      throw SharedPreferenceReadFailure("Failed to read bool for key: $key");
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      await _datasource.clearAll();
    } catch (e) {
      throw SharedPreferenceFailure("Failed to clear all SharedPreferences");
    }
  }
}
