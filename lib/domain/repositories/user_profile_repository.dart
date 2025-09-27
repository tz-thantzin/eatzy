import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<Users> getLastActiveUsersByPagination({
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
  });

  Future<Users> getUsersByPagination({
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
  });
}
