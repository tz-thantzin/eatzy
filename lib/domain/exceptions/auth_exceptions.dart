class NoUserInformationFailure implements Exception {
  const NoUserInformationFailure();
}

class AuthExceptions implements Exception {
  final String message;
  const AuthExceptions([this.message = 'auth_error_unknown']);
}

class LogInWithEmailAndPasswordFailure implements Exception {
  final String message;
  const LogInWithEmailAndPasswordFailure([this.message = 'auth_error_unknown']);

  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'auth_error_invalid_email',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'auth_error_user_disabled',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'auth_error_user_not_found',
        );
      case 'invalid-credential':
        return const LogInWithEmailAndPasswordFailure(
          'auth_error_invalid_credential',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'auth_error_wrong_password',
        );
      case 'error_empty_email]':
        return const LogInWithEmailAndPasswordFailure('auth_error_empty_email');
      case 'error_empty_password':
        return const LogInWithEmailAndPasswordFailure(
          'auth_error_empty_password',
        );
      default:
        return const LogInWithEmailAndPasswordFailure('auth_error_unknown');
    }
  }
}

class LogInWithGoogleFailure implements Exception {
  final String message;

  const LogInWithGoogleFailure([this.message = 'auth_error_unknown']);

  factory LogInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithGoogleFailure(
          'auth_error_account_exists_diff_cred',
        );
      case 'invalid-credential':
        return const LogInWithGoogleFailure('auth_error_invalid_credential');
      case 'operation-not-allowed':
        return const LogInWithGoogleFailure('auth_error_operation_not_allowed');
      case 'user-disabled':
        return const LogInWithGoogleFailure('auth_error_user_disabled');
      case 'user-not-found':
        return const LogInWithGoogleFailure('auth_error_user_not_found');
      case 'wrong-password':
        return const LogInWithGoogleFailure('auth_error_wrong_password');
      case 'invalid-verification-code':
        return const LogInWithGoogleFailure(
          'auth_error_invalid_verification_code',
        );
      case 'invalid-verification-id':
        return const LogInWithGoogleFailure(
          'auth_error_invalid_verification_id',
        );
      default:
        return const LogInWithGoogleFailure('auth_error_unknown');
    }
  }
}

class SignUpWithEmailAndPasswordFailure implements Exception {
  final String message;
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'auth_error_unknown',
  ]);

  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'auth_error_invalid_email',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'auth_error_user_disabled',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'auth_error_email_in_use',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'auth_error_operation_not_allowed',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'auth_error_weak_password',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure('auth_error_unknown');
    }
  }
}

class SendPasswordResetEmailFailure implements Exception {
  final String message;

  const SendPasswordResetEmailFailure([this.message = 'auth_error_unknown']);

  factory SendPasswordResetEmailFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SendPasswordResetEmailFailure('auth_error_invalid_email');
      case 'user-not-found':
        return const SendPasswordResetEmailFailure('auth_error_user_not_found');
      default:
        return const SendPasswordResetEmailFailure('auth_error_unknown');
    }
  }
}
