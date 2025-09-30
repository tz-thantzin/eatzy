import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/entities/user.dart';
import '../../domain/exceptions/auth_exceptions.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_datasource.dart';
import '../model/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _datasource;

  AuthRepositoryImpl(this._datasource);

  @override
  Stream<User?> get user =>
      _datasource.user.map((UserModel? u) => u?.toEntity());

  @override
  Future<User> checkUserInfo() async {
    final UserModel? user = await _datasource.checkUserInformation();
    if (user == null) {
      throw const NoUserInformationFailure();
    }

    return user.toEntity();
  }

  @override
  Future<User> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final UserModel? user = await _datasource.loginWithEmail(email, password);
      if (user == null) {
        throw const LogInWithEmailAndPasswordFailure();
      }
      return user.toEntity();
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<User?> loginWithGoogle() async {
    try {
      final UserModel? user = await _datasource.loginWithGoogle();
      return user?.toEntity();
    } on GoogleSignInException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code.name);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (e, st) {
      log('loginWithGoogles : ', error: e, stackTrace: st);
      throw const LogInWithGoogleFailure();
    }
  }

  @override
  Future<User?> signupWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final UserModel? user = await _datasource.signupWithEmail(
        email,
        password,
      );
      if (user == null) {
        throw const SignUpWithEmailAndPasswordFailure();
      }
      return user.toEntity();
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _datasource.sendPasswordResetEmail(email);
    } catch (e) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<void> sendEmailVerification() => _datasource.sendEmailVerification();

  @override
  Future<void> logout() => _datasource.logout();
}
