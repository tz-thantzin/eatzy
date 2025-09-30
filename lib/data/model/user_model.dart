import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';

class UserModel extends Equatable {
  final String uid;
  final String? email;
  final String? name;
  final String? photo;
  final Uint8List? imageBytes;
  final DateTime? dob;
  final DateTime? lastLogin;
  final String? gender;
  final bool isEmailVerified;

  const UserModel({
    required this.uid,
    this.email,
    this.name,
    this.photo,
    this.imageBytes,
    this.dob,
    this.lastLogin,
    this.gender,
    this.isEmailVerified = false,
  });

  /// From FirebaseAuth User
  factory UserModel.fromFirebaseUser(dynamic firebaseUser) {
    return UserModel(
      uid: firebaseUser.uid,
      email: firebaseUser.signupEmail,
      name: firebaseUser.displayName,
      photo: firebaseUser.photoURL,
      lastLogin: firebaseUser.metadata?.lastSignInTime,
      isEmailVerified: firebaseUser.emailVerified,
    );
  }

  /// From Firestore Document
  factory UserModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return UserModel(
      uid: doc.id,
      email: data['email'] as String?,
      name: data['name'] as String?,
      photo: data['photo'] as String?,
      dob: data['dob'] != null ? (data['dob'] as Timestamp).toDate() : null,
      gender: data['gender'] as String?,
      lastLogin: data['lastLogin'] != null
          ? (data['lastLogin'] as Timestamp).toDate()
          : null,
      isEmailVerified: data['isEmailVerified'] ?? false,
    );
  }

  /// To Firestore JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'photo': photo,
      'dob': dob != null ? Timestamp.fromDate(dob!) : null,
      'gender': gender,
      'lastLogin': lastLogin != null ? Timestamp.fromDate(lastLogin!) : null,
      'isEmailVerified': isEmailVerified,
    };
  }

  /// Convert to Domain Entity
  User toEntity() {
    return User(
      uid: uid,
      email: email,
      name: name,
      photo: photo,
      imageBytes: imageBytes,
      dob: dob,
      lastLogin: lastLogin,
      gender: gender,
      isEmailVerified: isEmailVerified,
    );
  }

  /// Create UserModel from Entity (useful for saving back to Firestore)
  factory UserModel.fromEntity(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email,
      name: user.name,
      photo: user.photo,
      imageBytes: user.imageBytes,
      dob: user.dob,
      lastLogin: user.lastLogin,
      gender: user.gender,
      isEmailVerified: user.isEmailVerified,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    uid,
    email,
    name,
    photo,
    imageBytes,
    dob,
    lastLogin,
    gender,
    isEmailVerified,
  ];

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, name: $name, photo: $photo, imageBytes: ${imageBytes?.isNotEmpty},  dob: $dob , lastLogin: $lastLogin, gender: $gender, isEmailVerified: $isEmailVerified)';
  }
}
