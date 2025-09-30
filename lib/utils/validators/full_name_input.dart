import 'package:formz/formz.dart';

enum FullNameValidationError { empty, tooShort, invalid }

class FullNameInput extends FormzInput<String, FullNameValidationError> {
  const FullNameInput.pure() : super.pure('');
  const FullNameInput.dirty([super.value = '']) : super.dirty();

  // Allow letters (A–Z, a–z), spaces, hyphens, apostrophes
  static final RegExp _regex = RegExp(r"^[a-zA-Z\s'-]+$");

  @override
  FullNameValidationError? validator(String value) {
    if (value.trim().isEmpty) {
      return FullNameValidationError.empty;
    }
    if (value.trim().length < 2) {
      return FullNameValidationError.tooShort;
    }
    return _regex.hasMatch(value.trim())
        ? null
        : FullNameValidationError.invalid;
  }
}
