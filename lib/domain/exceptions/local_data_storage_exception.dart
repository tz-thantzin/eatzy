class SharedPreferenceFailure implements Exception {
  final String message;
  const SharedPreferenceFailure([this.message = "SharedPreference error"]);

  @override
  String toString() => "SharedPreferenceFailure: $message";
}

/// Thrown when saving a value fails
class SharedPreferenceSaveFailure extends SharedPreferenceFailure {
  const SharedPreferenceSaveFailure([super.message = "Failed to save value"]);
}

/// Thrown when reading a value fails
class SharedPreferenceReadFailure extends SharedPreferenceFailure {
  const SharedPreferenceReadFailure([super.message = "Failed to read value"]);
}

/// Thrown when a requested key does not exist
class SharedPreferenceKeyNotFoundFailure extends SharedPreferenceFailure {
  const SharedPreferenceKeyNotFoundFailure([
    super.message = "Key not found in SharedPreferences",
  ]);
}

/// Thrown when clearing all values fails
class SharedPreferenceClearFailure extends SharedPreferenceFailure {
  const SharedPreferenceClearFailure([
    super.message = "Failed to clear all values",
  ]);
}
