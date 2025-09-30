import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatzy/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../constants.dart';

class UserProfileDatasource {
  final FirebaseFirestore _firestore;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  UserProfileDatasource({
    FirebaseFirestore? firestore,
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  Future<void> saveUserProfile({
    required String uid,
    required String fullName,
    required String email,
    required String phoneNumber,
    DateTime? dob,
    String? photoURL,
    String? imagePath,
  }) async {
    String? base64Image;
    if (imagePath != null) {
      final File file = File(imagePath);

      if (!file.existsSync()) {
        throw Exception('storage_error_file_not_found');
      }

      // Compress and check null
      final Uint8List? compressedBytes =
          await FlutterImageCompress.compressWithFile(
            imagePath,
            quality: 30, // tweak for size/quality balance
          );

      if (compressedBytes == null) {
        throw Exception('storage_error_image_compression_failed');
      }

      // Encode as Base64
      base64Image = base64Encode(compressedBytes);

      final double sizeKB = base64Image.length * 3 / 4 / 1024;
      if (sizeKB > 900) {
        throw Exception('storage_error_image_too_large');
      }
    }

    final DocumentReference<Map<String, dynamic>> userRef = _firestore
        .collection('users')
        .doc(uid);
    final DocumentSnapshot<Map<String, dynamic>> doc = await userRef.get();
    final bool isNewUser = !doc.exists;
    await userRef.set(<String, dynamic>{
      UserFields.fullName: fullName,
      UserFields.email: email,
      UserFields.photoURL: photoURL,
      UserFields.dob: dob?.toIso8601String(),
      UserFields.phoneNumber: phoneNumber,
      UserFields.updatedAt: FieldValue.serverTimestamp(),
      UserFields.lastLogin: FieldValue.serverTimestamp(),
      if (isNewUser) UserFields.createdAt: FieldValue.serverTimestamp(),
      if (base64Image != null) UserFields.profilePic: base64Image,
    }, SetOptions(merge: true));
  }

  Future<UserModel> getUserProfile({
    required String uid,
    required String email,
  }) async {
    final DocumentReference<Map<String, dynamic>> userRef = _firestore
        .collection('users')
        .doc(uid);
    final DocumentSnapshot<Map<String, dynamic>> snapshot = await userRef.get();
    final firebase_auth.User? currentUser = _firebaseAuth.currentUser;

    if (!snapshot.exists) {
      return UserModel(
        uid: uid,
        email: email,
        lastLogin: currentUser?.metadata.lastSignInTime,
        isEmailVerified: currentUser?.emailVerified ?? false,
      );
    }

    await userRef.set(<String, dynamic>{
      UserFields.lastLogin: FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    final Map<String, dynamic> data = snapshot.data() ?? <String, dynamic>{};
    final String? base64Image = data[UserFields.profilePic] is String
        ? data[UserFields.profilePic] as String
        : null;

    return UserModel(
      uid: uid,
      name: data[UserFields.fullName] ?? '',
      email: data[UserFields.email] ?? '',
      dob: data[UserFields.dob] != null
          ? DateTime.tryParse(data[UserFields.dob])
          : null,
      photoURL: data[UserFields.photoURL],
      profilePic: base64Image != null ? base64Decode(base64Image) : null,
      phoneNumber: data[UserFields.phoneNumber],
      lastLogin: currentUser?.metadata.lastSignInTime,
      isEmailVerified: currentUser?.emailVerified ?? false,
    );
  }
}
