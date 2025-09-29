import 'package:formz/formz.dart';

enum PasswordValidationError { invalid, empty }

enum ConfirmPasswordValidationError { invalid, empty, mismatch }

class PasswordInput extends FormzInput<String, PasswordValidationError> {
  const PasswordInput.pure() : super.pure('');
  const PasswordInput.dirty([super.value = '']) : super.dirty();
  static final RegExp _regex = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$&*~]).{8,}$',
  );

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    }
    return _regex.hasMatch(value) ? null : PasswordValidationError.invalid;
  }
}

class ConfirmPasswordInput
    extends FormzInput<String, ConfirmPasswordValidationError> {
  final String password;

  const ConfirmPasswordInput.pure({this.password = ''}) : super.pure('');
  const ConfirmPasswordInput.dirty({required this.password, String value = ''})
    : super.dirty(value);

  @override
  ConfirmPasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return ConfirmPasswordValidationError.empty;
    }

    if (value != password) {
      return ConfirmPasswordValidationError.mismatch;
    }
    return null;
  }
}
