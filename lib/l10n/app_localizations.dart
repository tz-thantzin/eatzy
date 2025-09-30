import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @get_started.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get get_started;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @welcome_message.
  ///
  /// In en, this message translates to:
  /// **'Hungry already? Sign in now and let us take care of your next meal, anytime, anywhere.'**
  String get welcome_message;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgot_password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signup_with.
  ///
  /// In en, this message translates to:
  /// **'or signup with'**
  String get signup_with;

  /// No description provided for @not_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have account?'**
  String get not_have_account;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Signup'**
  String get signup;

  /// No description provided for @new_account.
  ///
  /// In en, this message translates to:
  /// **'New Account'**
  String get new_account;

  /// No description provided for @full_name.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get full_name;

  /// No description provided for @mobile_number.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobile_number;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'123456789'**
  String get phone_number;

  /// No description provided for @dob.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dob;

  /// No description provided for @dob_format.
  ///
  /// In en, this message translates to:
  /// **'DD / MM / YYYY'**
  String get dob_format;

  /// No description provided for @continue_you_agree_to.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to '**
  String get continue_you_agree_to;

  /// No description provided for @terms_of_use.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get terms_of_use;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy.'**
  String get privacy_policy;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get sign_up;

  /// No description provided for @already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get already_have_account;

  /// No description provided for @forgot_password_description.
  ///
  /// In en, this message translates to:
  /// **'We’ll email you a secure link to reset your password. Please check your inbox after submitting.'**
  String get forgot_password_description;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @invalid_email.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address'**
  String get invalid_email;

  /// No description provided for @email_empty.
  ///
  /// In en, this message translates to:
  /// **'Email cannot be empty'**
  String get email_empty;

  /// No description provided for @password_empty.
  ///
  /// In en, this message translates to:
  /// **'Password cannot be empty'**
  String get password_empty;

  /// No description provided for @invalid_password.
  ///
  /// In en, this message translates to:
  /// **'Must contain upper, lower, number, special char'**
  String get invalid_password;

  /// No description provided for @confirm_password_empty.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password cannot be empty'**
  String get confirm_password_empty;

  /// No description provided for @password_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get password_not_match;

  /// No description provided for @auth_error_user_canceled.
  ///
  /// In en, this message translates to:
  /// **'Signup was cancelled by the user.'**
  String get auth_error_user_canceled;

  /// No description provided for @auth_error_invalid_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get auth_error_invalid_email;

  /// No description provided for @auth_error_invalid_credential.
  ///
  /// In en, this message translates to:
  /// **'The email or password you entered is incorrect. Please try again.'**
  String get auth_error_invalid_credential;

  /// No description provided for @auth_error_user_disabled.
  ///
  /// In en, this message translates to:
  /// **'Your account has been disabled. Contact support.'**
  String get auth_error_user_disabled;

  /// No description provided for @auth_error_user_not_found.
  ///
  /// In en, this message translates to:
  /// **'No account found with that email.'**
  String get auth_error_user_not_found;

  /// No description provided for @auth_error_wrong_password.
  ///
  /// In en, this message translates to:
  /// **'The password you entered is incorrect.'**
  String get auth_error_wrong_password;

  /// No description provided for @auth_error_email_in_use.
  ///
  /// In en, this message translates to:
  /// **'An account already exists for that email.'**
  String get auth_error_email_in_use;

  /// No description provided for @auth_error_weak_password.
  ///
  /// In en, this message translates to:
  /// **'Please choose a stronger password.'**
  String get auth_error_weak_password;

  /// No description provided for @auth_error_account_exists_diff_cred.
  ///
  /// In en, this message translates to:
  /// **'An account already exists with a different sign-in method.'**
  String get auth_error_account_exists_diff_cred;

  /// No description provided for @unknown_error.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again later.'**
  String get unknown_error;

  /// No description provided for @send_reset_password.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Password'**
  String get send_reset_password;

  /// No description provided for @sent_reset_password_link.
  ///
  /// In en, this message translates to:
  /// **'Password reset link has been sent to your email.'**
  String get sent_reset_password_link;

  /// No description provided for @email_not_verified.
  ///
  /// In en, this message translates to:
  /// **'Your email is not verified. Please verify it and log in again.'**
  String get email_not_verified;

  /// No description provided for @full_name_empty.
  ///
  /// In en, this message translates to:
  /// **'Full name cannot be empty'**
  String get full_name_empty;

  /// No description provided for @full_name_too_short.
  ///
  /// In en, this message translates to:
  /// **'Full name is too short'**
  String get full_name_too_short;

  /// No description provided for @full_name_invalid.
  ///
  /// In en, this message translates to:
  /// **'Full name contains invalid characters'**
  String get full_name_invalid;

  /// No description provided for @phone_number_error_empty.
  ///
  /// In en, this message translates to:
  /// **'Phone number cannot be empty'**
  String get phone_number_error_empty;

  /// No description provided for @phone_number_error_too_short.
  ///
  /// In en, this message translates to:
  /// **'Phone number is too short'**
  String get phone_number_error_too_short;

  /// No description provided for @phone_number_error_invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number format'**
  String get phone_number_error_invalid;

  /// No description provided for @no_country_code.
  ///
  /// In en, this message translates to:
  /// **'Country Code cannot be empty'**
  String get no_country_code;

  /// No description provided for @dob_empty.
  ///
  /// In en, this message translates to:
  /// **'Date of birth cannot be empty'**
  String get dob_empty;

  /// No description provided for @dob_invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid date of birth'**
  String get dob_invalid;

  /// No description provided for @dob_underage.
  ///
  /// In en, this message translates to:
  /// **'You must be at least 12 years old'**
  String get dob_underage;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
