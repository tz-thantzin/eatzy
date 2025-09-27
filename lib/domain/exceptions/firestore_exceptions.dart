class SaveUserProfileFailure implements Exception {
  final String message;
  const SaveUserProfileFailure([this.message = 'storage_error_unknown']);

  factory SaveUserProfileFailure.fromCode(String code) {
    switch (code) {
      case 'permission-denied':
        return const SaveUserProfileFailure('storage_error_permission_denied');
      case 'canceled':
        return const SaveUserProfileFailure('storage_error_canceled');
      case 'invalid-argument':
        return const SaveUserProfileFailure('storage_error_invalid_argument');
      case 'resource-exhausted':
        return const SaveUserProfileFailure('storage_error_too_large');
      case 'not-found':
        return const SaveUserProfileFailure('storage_error_not_found');
      default:
        return const SaveUserProfileFailure('storage_error_unknown');
    }
  }
}

/// Exception for Common Firestore errors
class RetrievingFirestoreFailure implements Exception {
  final String message;
  const RetrievingFirestoreFailure([this.message = 'storage_error_unknown']);

  factory RetrievingFirestoreFailure.fromCode(String code) {
    switch (code) {
      case 'not-found':
        return const RetrievingFirestoreFailure('storage_error_not_found');
      case 'permission-denied':
        return const RetrievingFirestoreFailure(
          'storage_error_permission_denied',
        );
      default:
        return const RetrievingFirestoreFailure('storage_error_unknown');
    }
  }
}
