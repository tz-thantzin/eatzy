import '../entities/user.dart';

abstract class UserProfileRepository {
  Future<void> saveUserProfile({
    required String uid,
    required String fullName,
    required String email,
    required String phoneNumber,
    DateTime? dob,
    String? photoURL, // from google sign in
    String? profilePic, // user upload profile pic
  });

  Future<User> getUserProfile({required String uid, required String email});
}
