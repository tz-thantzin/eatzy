import 'package:formz/formz.dart';

enum PhoneNumberValidationError { empty, tooShort, invalid, noCountryCode }

class PhoneNumberInput extends FormzInput<String, PhoneNumberValidationError> {
  final String? countryCode;

  const PhoneNumberInput.pure({this.countryCode}) : super.pure('');
  const PhoneNumberInput.dirty({required String value, this.countryCode})
    : super.dirty(value);

  static final RegExp _regex = RegExp(r'^[0-9]+$');

  @override
  PhoneNumberValidationError? validator(String value) {
    final trimmed = value.trim();

    if (countryCode == null || countryCode!.isEmpty) {
      return PhoneNumberValidationError.noCountryCode;
    }
    if (trimmed.isEmpty) {
      return PhoneNumberValidationError.empty;
    }
    if (trimmed.length < 6) {
      return PhoneNumberValidationError.tooShort;
    }
    return _regex.hasMatch(trimmed) ? null : PhoneNumberValidationError.invalid;
  }
}
