import 'dart:developer';

import 'package:eatzy/domain/constants.dart';

import '../../domain/exceptions/local_data_storage_exception.dart';
import '../../domain/repositories/shared_preference_repository.dart';

class SharedPreferenceUseCase {
  final SharedPreferenceRepository _repository;

  SharedPreferenceUseCase(this._repository);

  Future<void> setOnboardingCompleted(bool value) async {
    try {
      await _repository.saveBool(SharedPreferenceKey.onBoarding, value);
    } on SharedPreferenceFailure catch (_) {
      log('setting on boarding complete data was failure');
    }
  }

  /// Get operations
  Future<bool> isOnboardingCompleted() async {
    try {
      return (await _repository.getBool(SharedPreferenceKey.onBoarding) ??
          false);
    } on SharedPreferenceFailure catch (_) {
      return false;
    }
  }

  /// Clear all preferences
  Future<void> clearAll() async {
    try {
      await _repository.clearAll();
    } on SharedPreferenceFailure catch (_) {
      rethrow;
    }
  }
}
