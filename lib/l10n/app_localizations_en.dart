// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get skip => 'Skip';

  @override
  String get next => 'Next';

  @override
  String get get_started => 'Get Started';

  @override
  String get welcome => 'Welcome';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirm_password => 'Confirm Password';

  @override
  String get forgot_password => 'Forgot Password';

  @override
  String get login => 'Login';

  @override
  String get signup_with => 'or signup with';

  @override
  String get not_have_account => 'Don\'t have account?';

  @override
  String get signup => 'Signup';

  @override
  String get new_account => 'New Account';

  @override
  String get full_name => 'Full name';

  @override
  String get mobile_number => 'Mobile Number';

  @override
  String get phone_number => '123456789';

  @override
  String get dob => 'Date of Birth';

  @override
  String get dob_format => 'DD / MM / YYYY';

  @override
  String get continue_you_agree_to => 'By continuing, you agree to ';

  @override
  String get terms_of_use => 'Terms of Use';

  @override
  String get and => 'and';

  @override
  String get privacy_policy => 'Privacy Policy.';

  @override
  String get sign_up => 'Sign Up';

  @override
  String get already_have_account => 'Already have an account?';

  @override
  String get invalid_email => 'Invalid email address';

  @override
  String get email_empty => 'Email cannot be empty';

  @override
  String get password_empty => 'Password cannot be empty';

  @override
  String get invalid_password => 'Must contain upper, lower, number, special char';

  @override
  String get confirm_password_empty => 'Confirm Password cannot be empty';

  @override
  String get password_not_match => 'Passwords do not match';

  @override
  String get auth_error_user_canceled => 'Signup was cancelled by the user.';

  @override
  String get auth_error_invalid_email => 'Please enter a valid email address.';

  @override
  String get auth_error_invalid_credential => 'The email or password you entered is incorrect. Please try again.';

  @override
  String get auth_error_user_disabled => 'Your account has been disabled. Contact support.';

  @override
  String get auth_error_user_not_found => 'No account found with that email.';

  @override
  String get auth_error_wrong_password => 'The password you entered is incorrect.';

  @override
  String get auth_error_email_in_use => 'An account already exists for that email.';

  @override
  String get auth_error_weak_password => 'Please choose a stronger password.';

  @override
  String get auth_error_account_exists_diff_cred => 'An account already exists with a different sign-in method.';

  @override
  String get unknown_error => 'Something went wrong. Please try again later.';

  @override
  String get send_reset_password => 'Send Reset Password';

  @override
  String get sent_reset_password_link => 'Password reset link has been sent to your email.';

  @override
  String get email_not_verified => 'Your email is not verified. Please verify it and log in again.';

  @override
  String get full_name_empty => 'Full name cannot be empty';

  @override
  String get full_name_too_short => 'Full name is too short';

  @override
  String get full_name_invalid => 'Full name contains invalid characters';

  @override
  String get phone_number_error_empty => 'Phone number cannot be empty';

  @override
  String get phone_number_error_too_short => 'Phone number is too short';

  @override
  String get phone_number_error_invalid => 'Invalid phone number format';

  @override
  String get no_country_code => 'Country Code cannot be empty';

  @override
  String get dob_empty => 'Date of birth cannot be empty';

  @override
  String get dob_invalid => 'Invalid date of birth';

  @override
  String get dob_underage => 'You must be at least 12 years old';
}
