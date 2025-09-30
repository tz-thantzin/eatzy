import 'dart:developer';

import '../entities/user.dart';
import '../exceptions/firestore_exceptions.dart';
import '../repositories/user_profile_repository.dart';

class UserUseCase {
  final UserProfileRepository _repository;

  UserUseCase(this._repository);

  Future<void> saveUserProfile({
    required String uid,
    required String fullName,
    required String email,
    required String phoneNumber,
    DateTime? dob,
    String? photoURL, // from google sign in
    String? profilePicPath, // user upload profile pic
  }) async {
    try {
      await _repository.saveUserProfile(
        uid: uid,
        fullName: fullName,
        email: email,
        photoURL: photoURL,
        profilePic: profilePicPath,
        dob: dob,
        phoneNumber: phoneNumber,
      );
    } on SaveUserProfileFailure catch (e, stackTrace) {
      log(
        'UserUseCase:: Unexpected error in saveUserProfile',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    } catch (e, stackTrace) {
      log(
        'UserUseCase:: Unexpected error in saveUserProfile',
        error: e,
        stackTrace: stackTrace,
      );
      throw const SaveUserProfileFailure();
    }
  }

  Future<User?> getUserProfile({
    required String uid,
    required String email,
  }) async {
    try {
      return await _repository.getUserProfile(uid: uid, email: email);
    } on RetrievingFirestoreFailure catch (e, stackTrace) {
      log(
        'UserUseCase:: Unexpected error in getUserProfile',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    } catch (e, stackTrace) {
      log(
        'UserUseCase:: Unexpected error in getUserProfile',
        error: e,
        stackTrace: stackTrace,
      );
      throw const RetrievingFirestoreFailure();
    }
  }
}
