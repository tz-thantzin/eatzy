part of 'login_cubit.dart';

enum LoginStatus {
  initial,
  loginEmailInProgress,
  loginGoogleInProgress,
  resetPasswordInProgress,
  success,
  failure,
  canceled,
  resetPasswordSuccess,
  resetPasswordFailure,
}

class LoginState extends Equatable {
  final User? user;
  final LoginStatus status;
  final EmailInput loginEmail;
  final PasswordInput loginPassword;
  final EmailInput resetPasswordEmail;

  final String? errorMessage;

  const LoginState({
    this.user,
    this.status = LoginStatus.initial,
    this.loginEmail = const EmailInput.pure(),
    this.loginPassword = const PasswordInput.pure(),
    this.resetPasswordEmail = const EmailInput.pure(),
    this.errorMessage,
  });

  factory LoginState.initial() => const LoginState();

  LoginState copyWith({
    User? user,
    LoginStatus? status,
    EmailInput? loginEmail,
    PasswordInput? loginPassword,
    EmailInput? resetPasswordEmail,
    String? errorMessage,
  }) {
    return LoginState(
      user: user ?? this.user,
      status: status ?? this.status,
      loginEmail: loginEmail ?? this.loginEmail,
      loginPassword: loginPassword ?? this.loginPassword,
      resetPasswordEmail: resetPasswordEmail ?? this.resetPasswordEmail,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  /// LOGIN
  LoginState loginEmailChanged(String email) {
    return copyWith(
      loginEmail: EmailInput.dirty(email),
      loginPassword: loginPassword,
    );
  }

  LoginState loginPasswordChanged(String password) {
    return copyWith(
      loginEmail: loginEmail,
      loginPassword: PasswordInput.dirty(password),
    );
  }

  LoginState resetPasswordEmailChanged(String email) {
    return copyWith(resetPasswordEmail: EmailInput.dirty(email));
  }

  bool get isLoginValid =>
      Formz.validate(<FormzInput<String, dynamic>>[loginEmail, loginPassword]);

  bool get isForgotPasswordValid =>
      Formz.validate(<FormzInput<String, dynamic>>[resetPasswordEmail]);

  @override
  List<Object?> get props => <Object?>[
    user,
    status,
    loginEmail,
    loginPassword,
    resetPasswordEmail,
    errorMessage,
  ];
}

extension LoginStateStatusX on LoginState {
  bool get isInitial => status == LoginStatus.initial;

  bool get isLoginEmailInProgress => status == LoginStatus.loginEmailInProgress;

  bool get isLoginGoogleInProgress =>
      status == LoginStatus.loginGoogleInProgress;

  bool get isResetPasswordInProgress =>
      status == LoginStatus.resetPasswordInProgress;

  bool get isSuccess => status == LoginStatus.success;

  bool get isFailure => status == LoginStatus.failure;
}

extension LoginStateValidationMsg on LoginState {
  String? emailErrorText(BuildContext context) {
    EmailValidationError? displayError = loginEmail.displayError;

    return displayError != null ? context.localization.invalid_email : null;
  }

  String? passwordErrorText(BuildContext context) {
    PasswordValidationError? displayError = loginPassword.displayError;

    switch (displayError) {
      case PasswordValidationError.empty:
        return context.localization.password_empty;
      case PasswordValidationError.invalid:
        return context.localization.invalid_password;
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
      case 'auth_error_user_canceled':
        return context.localization.auth_error_user_canceled;
      default:
        return context.localization.unknown_error;
    }
  }
}
