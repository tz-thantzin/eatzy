import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart' as firebase_core;

import '../../domain/entities/user.dart';
import '../../domain/exception/firestore_exceptions.dart';
import '../../domain/repositories/storage_repository.dart';
import '../constants.dart';
import '../data_sources/user_profile_datasource.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileDatasource _datasource;

  UserProfileRepositoryImpl(this._datasource);

  @override
  Future<void> saveUserProfile({
    required String uid,
    required String fullName,
    required String email,
    required String? imagePath,
    required DateTime? dob,
    required String? gender,
  }) async {
    try {
      await _datasource.saveUserProfile(
        uid: uid,
        fullName: fullName,
        email: email,
        imagePath: imagePath,
        dob: dob,
        gender: gender,
      );
    } on firebase_core.FirebaseException catch (e, stacktrace) {
      log('Unknown Error saveUserProfile', error: e, stackTrace: stacktrace);
      throw SaveUserProfileFailure.fromCode(e.code);
    } catch (_) {
      throw const SaveUserProfileFailure();
    }
  }

  @override
  Future<User> getUserProfile({
    required String uid,
    required String email,
  }) async {
    try {
      return await _datasource.getUserProfile(uid: uid, email: email);
    } on firebase_core.FirebaseException catch (e) {
      throw RetrievingFirestoreFailure.fromCode(e.code);
    } catch (_) {
      throw const RetrievingFirestoreFailure();
    }
  }

  @override
  Future<Users> getLastActiveUsersByPagination({
    firebase_core.DocumentSnapshot<Map<String, dynamic>>? lastDocument,
  }) async {
    try {
      return await _datasource.getLastActiveUsersByPagination(
        limit: Constants.limitPerRequest,
        lastDocument: lastDocument,
      );
    } on firebase_core.FirebaseException catch (e) {
      log('error ${e}');
      throw RetrievingFirestoreFailure.fromCode(e.code);
    } catch (_) {
      throw const RetrievingFirestoreFailure();
    }
  }

  @override
  Future<Users> getUsersByPagination({
    firebase_core.DocumentSnapshot<Map<String, dynamic>>? lastDocument,
  }) async {
    try {
      return await _datasource.getUsersByPagination(
        limit: Constants.limitPerRequest,
        lastDocument: lastDocument,
      );
    } on firebase_core.FirebaseException catch (e) {
      throw RetrievingFirestoreFailure.fromCode(e.code);
    } catch (_) {
      throw const RetrievingFirestoreFailure();
    }
  }
}
