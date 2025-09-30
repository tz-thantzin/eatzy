part of 'signup_cubit.dart';

enum SignupStatus {
  initial,
  signupEmailInProgress,
  signupGoogleInProgress,
  success,
  failure,
  canceled,
}

const _defaultCountryCode = '+66';

class SignupState extends Equatable {
  final User? user;
  final SignupStatus status;
  final FullNameInput fullName;
  final EmailInput signupEmail;
  final PasswordInput signupPassword;
  final ConfirmPasswordInput signupConfirmPassword;
  final PhoneNumberInput phoneNumber;
  final DobInput dob;
  final String countryCode;

  final String? errorMessage;

  const SignupState({
    this.user,
    this.status = SignupStatus.initial,
    this.fullName = const FullNameInput.pure(),
    this.signupEmail = const EmailInput.pure(),
    this.signupPassword = const PasswordInput.pure(),
    this.signupConfirmPassword = const ConfirmPasswordInput.pure(),
    this.phoneNumber = const PhoneNumberInput.pure(),
    this.dob = const DobInput.pure(),
    this.countryCode = _defaultCountryCode,
    this.errorMessage,
  });

  factory SignupState.initial() => const SignupState();

  SignupState copyWith({
    User? user,
    SignupStatus? status,
    FullNameInput? fullName,
    EmailInput? signupEmail,
    PasswordInput? signupPassword,
    ConfirmPasswordInput? signupConfirmPassword,
    PhoneNumberInput? phoneNumber,
    DobInput? dob,
    String? countryCode,
    String? errorMessage,
  }) {
    return SignupState(
      user: user ?? this.user,
      status: status ?? this.status,
      fullName: fullName ?? this.fullName,
      signupEmail: signupEmail ?? this.signupEmail,
      signupPassword: signupPassword ?? this.signupPassword,
      signupConfirmPassword:
          signupConfirmPassword ?? this.signupConfirmPassword,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dob: dob ?? this.dob,
      countryCode: countryCode ?? this.countryCode,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  /// Signup
  SignupState fullNameChanged(String fullName) {
    return copyWith(fullName: FullNameInput.dirty(fullName));
  }

  SignupState signupEmailChanged(String email) {
    return copyWith(
      signupEmail: EmailInput.dirty(email),
      signupPassword: signupPassword,
    );
  }

  SignupState signupPasswordChanged(String password) {
    return copyWith(
      signupEmail: signupEmail,
      signupPassword: PasswordInput.dirty(password),
    );
  }

  SignupState signupConfirmPasswordChanged(String confirmPassword) {
    return copyWith(
      signupEmail: signupEmail,
      signupPassword: signupPassword,
      signupConfirmPassword: ConfirmPasswordInput.dirty(
        password: signupPassword.value,
        value: confirmPassword,
      ),
    );
  }

  SignupState countryCodeChanged(String? countryCode) {
    return copyWith(countryCode: countryCode);
  }

  SignupState phoneNumberChanged(String phoneNumber) {
    return copyWith(
      phoneNumber: PhoneNumberInput.dirty(
        value: phoneNumber,
        countryCode: countryCode,
      ),
    );
  }

  SignupState dobChanged(DateTime dob) {
    return copyWith(dob: DobInput.dirty(dob));
  }

  bool get isSignupValid => Formz.validate(<FormzInput<dynamic, dynamic>>[
    fullName,
    signupEmail,
    signupPassword,
    signupConfirmPassword,
    phoneNumber,
    dob,
  ]);

  @override
  List<Object?> get props => <Object?>[
    user,
    status,
    fullName,
    signupEmail,
    signupPassword,
    signupConfirmPassword,
    countryCode,
    phoneNumber,
    dob,
    errorMessage,
  ];
}

extension SignupStateStatusX on SignupState {
  bool get isInitial => status == SignupStatus.initial;

  bool get isSignupEmailInProgress =>
      status == SignupStatus.signupEmailInProgress;

  bool get isSignupGoogleInProgress =>
      status == SignupStatus.signupGoogleInProgress;

  bool get isSuccess => status == SignupStatus.success;

  bool get isFailure => status == SignupStatus.failure;
}

extension SignupStateValidationMsg on SignupState {
  String? fullNameErrorText(BuildContext context) {
    FullNameValidationError? displayError = fullName.displayError;

    switch (displayError) {
      case FullNameValidationError.empty:
        return context.localization.full_name_empty;
      case FullNameValidationError.invalid:
        return context.localization.full_name_invalid;
      case FullNameValidationError.tooShort:
        return context.localization.full_name_too_short;
      default:
        return null;
    }
  }

  String? emailErrorText(BuildContext context) {
    EmailValidationError? displayError = signupEmail.displayError;

    return displayError != null ? context.localization.invalid_email : null;
  }

  String? passwordErrorText(BuildContext context) {
    PasswordValidationError? displayError = signupPassword.displayError;

    switch (displayError) {
      case PasswordValidationError.empty:
        return context.localization.password_empty;
      case PasswordValidationError.invalid:
        return context.localization.invalid_password;
      default:
        return null;
    }
  }

  String? confirmPasswordErrorText(BuildContext context) {
    ConfirmPasswordValidationError? displayError =
        signupConfirmPassword.displayError;

    switch (displayError) {
      case ConfirmPasswordValidationError.empty:
        return context.localization.confirm_password_empty;
      case ConfirmPasswordValidationError.mismatch:
        return context.localization.password_not_match;
      default:
        return null;
    }
  }

  String? phoneNumberErrorText(BuildContext context) {
    PhoneNumberValidationError? displayError = phoneNumber.displayError;

    switch (displayError) {
      case PhoneNumberValidationError.empty:
        return context.localization.phone_number_error_empty;
      case PhoneNumberValidationError.tooShort:
        return context.localization.phone_number_error_too_short;
      case PhoneNumberValidationError.invalid:
        return context.localization.phone_number_error_invalid;
      case PhoneNumberValidationError.noCountryCode:
        return context.localization.no_country_code;
      default:
        return null;
    }
  }

  String? dobErrorText(BuildContext context) {
    DobValidationError? displayError = dob.displayError;

    switch (displayError) {
      case DobValidationError.empty:
        return context.localization.dob_empty;
      case DobValidationError.invalid:
        return context.localization.dob_invalid;
      case DobValidationError.underage:
        return context.localization.dob_underage;
      default:
        return null;
    }
  }

  String authFailureMsg(BuildContext context, String errorCode) {
    switch (errorCode) {
      case 'auth_error_invalid_email':
        return context.localization.auth_error_invalid_email;
      case 'auth_error_user_disabled':
        return context.localization.auth_error_user_disabled;
      case 'auth_error_user_not_found':
        return context.localization.auth_error_user_not_found;
      case 'auth_error_wrong_password':
        return context.localization.auth_error_wrong_password;
      case 'auth_error_email_in_use':
        return context.localization.auth_error_email_in_use;
      case 'auth_error_weak_password':
        return context.localization.auth_error_weak_password;
      case 'auth_error_account_exists_diff_cred':
        return context.localization.auth_error_account_exists_diff_cred;
      case 'auth_error_invalid_credential':
        return context.localization.auth_error_invalid_credential;
      case 'auth_error_empty_email':
        return context.localization.email_empty;
      case 'auth_error_empty_password':
        return context.localization.password_empty;
      default:
        return context.localization.unknown_error;
    }
  }
}
