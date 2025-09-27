import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../domain/entities/user.dart';
import '../../domain/exception/auth_exceptions.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _datasource;

  AuthRepositoryImpl(this._datasource);

  @override
  Stream<User?> get user =>
      _datasource.user.map((firebase_auth.User? u) => u?.toUser);

  @override
  Future<User> checkUserInfo() async {
    final firebase_auth.User? user = await _datasource.checkUserInformation();
    if (user == null) {
      throw const NoUserInformationFailure();
    }
    return user.toUser;
  }

  @override
  Future<User> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final firebase_auth.User? user = await _datasource.loginWithEmail(
        email,
        password,
      );
      if (user == null) {
        throw const LogInWithEmailAndPasswordFailure();
      }
      return user.toUser;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<User?> loginWithGoogle() async {
    try {
      final firebase_auth.User? user = await _datasource.loginWithGoogle();
      return user?.toUser;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (e) {
      throw const LogInWithGoogleFailure();
    }
  }

  @override
  Future<User?> signupWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final firebase_auth.User? user = await _datasource.signupWithEmail(
        email,
        password,
      );
      if (user == null) {
        throw const SignUpWithEmailAndPasswordFailure();
      }
      return user.toUser;
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

extension on firebase_auth.User {
  User get toUser => User(
    uid: uid,
    email: email,
    name: displayName,
    photo: photoURL,
    isEmailVerified: emailVerified,
  );
}
