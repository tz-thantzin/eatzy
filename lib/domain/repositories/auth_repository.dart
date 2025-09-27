import '../../domain/entities/user.dart';

abstract class AuthRepository {
  Stream<User?> get user;

  Future<User?> checkUserInfo();
  Future<User?> loginWithEmail({
    required String email,
    required String password,
  });
  Future<User?> loginWithGoogle();
  Future<User?> signupWithEmail({
    required String email,
    required String password,
  });
  Future<void> sendPasswordResetEmail({required String email});
  Future<void> sendEmailVerification();
  Future<void> logout();
}
