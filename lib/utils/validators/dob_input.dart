import 'package:formz/formz.dart';

enum DobValidationError { empty, invalid, underage }

class DobInput extends FormzInput<DateTime?, DobValidationError> {
  const DobInput.pure() : super.pure(null);
  const DobInput.dirty([super.value]) : super.dirty();

  static const int _minAge = 12;

  @override
  DobValidationError? validator(DateTime? value) {
    if (value == null) {
      return DobValidationError.empty;
    }

    final now = DateTime.now();

    // Future dates are invalid
    if (value.isAfter(now)) {
      return DobValidationError.invalid;
    }

    // Age check
    final age =
        now.year -
        value.year -
        ((now.month < value.month ||
                (now.month == value.month && now.day < value.day))
            ? 1
            : 0);

    if (age < _minAge) {
      return DobValidationError.underage;
    }

    return null;
  }
}
