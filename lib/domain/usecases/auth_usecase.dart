import 'dart:developer';

import '../entities/user.dart';
import '../exceptions/auth_exceptions.dart';
import '../exceptions/firestore_exceptions.dart';
import '../repositories/auth_repository.dart';
import '../repositories/user_profile_repository.dart';

class AuthUseCase {
  final AuthRepository _authRepository;
  final UserProfileRepository _userProfileRepository;

  AuthUseCase({
    required AuthRepository authRepository,
    required UserProfileRepository userProfileRepository,
  }) : _authRepository = authRepository,
       _userProfileRepository = userProfileRepository;

  Stream<User?> get user => _authRepository.user;

  Future<User?> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final User? user = await _authRepository.loginWithEmail(
        email: email,
        password: password,
      );
      return user;
    } on LogInWithEmailAndPasswordFailure catch (e, stackTrace) {
      log(
        'AuthUseCase:: Unexpected error in loginWithEmail',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    } catch (e, stackTrace) {
      log(
        'AuthUseCase:: Unexpected error in loginWithEmail',
        error: e,
        stackTrace: stackTrace,
      );
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  Future<User?> loginWithGoogle() async {
    try {
      final User? user = await _authRepository.loginWithGoogle();
      return user;
    } on LogInWithGoogleFailure catch (e, stackTrace) {
      log(
        'AuthUseCase:: Unexpected error in loginWithGoogle',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    } catch (e, stackTrace) {
      log(
        'AuthUseCase:: Unexpected error in loginWithGoogle',
        error: e,
        stackTrace: stackTrace,
      );
      throw const LogInWithGoogleFailure();
    }
  }

  Future<User?> signupWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final User? user = await _authRepository.signupWithEmail(
        email: email,
        password: password,
      );
      return user;
    } on SignUpWithEmailAndPasswordFailure catch (e, stackTrace) {
      log(
        'AuthUseCase:: Unexpected error in signupWithEmail',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    } catch (e, stackTrace) {
      log(
        'AuthUseCase:: Unexpected error in signupWithEmail',
        error: e,
        stackTrace: stackTrace,
      );
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _authRepository.sendPasswordResetEmail(email: email);
    } on SendPasswordResetEmailFailure catch (e, stackTrace) {
      log(
        'AuthUseCase:: Unexpected error in sendPasswordResetEmail',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    } catch (e, stackTrace) {
      log(
        'AuthUseCase:: Unexpected error in sendPasswordResetEmail',
        error: e,
        stackTrace: stackTrace,
      );
      throw const SendPasswordResetEmailFailure();
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _authRepository.sendEmailVerification();
    } catch (e, stackTrace) {
      log(
        'AuthUseCase:: Unexpected error in sendEmailVerification: ',
        error: e,
        stackTrace: stackTrace,
      );
      throw AuthExceptions(e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await _authRepository.logout();
    } catch (e, stackTrace) {
      log(
        'AuthUseCase:: Unexpected error in logout: ',
        error: e,
        stackTrace: stackTrace,
      );
      throw AuthExceptions(e.toString());
    }
  }

  Future<User> getUserProfile({
    required String uid,
    required String email,
  }) async {
    try {
      return await _userProfileRepository.getUserProfile(
        uid: uid,
        email: email,
      );
    } on RetrievingFirestoreFailure catch (e, stackTrace) {
      log(
        'AuthUseCase:: Unexpected error in getUserProfile',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    } catch (e, stackTrace) {
      log(
        'AuthUseCase:: Unexpected error in getUserProfile',
        error: e,
        stackTrace: stackTrace,
      );
      throw const RetrievingFirestoreFailure();
    }
  }
}
