import '../entities/user.dart';

abstract class UserProfileRepository {
  Future<void> saveUserProfile({
    required String uid,
    required String fullName,
    required String email,
    required String? imagePath,
    required DateTime? dob,
    required String? gender,
  });

  Future<User> getUserProfile({required String uid, required String email});
}
