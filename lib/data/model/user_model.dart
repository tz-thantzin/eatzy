import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatzy/data/constants.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';

class UserModel extends Equatable {
  final String uid;
  final String? email;
  final String? name;
  final String? photoURL;
  final Uint8List? profilePic;
  final String? phoneNumber;
  final DateTime? dob;
  final DateTime? lastLogin;
  final bool isEmailVerified;

  const UserModel({
    required this.uid,
    this.email,
    this.name,
    this.photoURL,
    this.profilePic,
    this.phoneNumber,
    this.dob,
    this.lastLogin,
    this.isEmailVerified = false,
  });

  /// From FirebaseAuth User
  factory UserModel.fromFirebaseUser(dynamic firebaseUser) {
    return UserModel(
      uid: firebaseUser.uid,
      email: firebaseUser.email,
      name: firebaseUser.displayName,
      photoURL: firebaseUser.photoURL,
      lastLogin: firebaseUser.metadata?.lastSignInTime,
      isEmailVerified: firebaseUser.emailVerified,
    );
  }

  /// From Firestore Document
  factory UserModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return UserModel(
      uid: doc.id,
      email: data[UserFields.email] as String?,
      name: data[UserFields.fullName] as String?,
      photoURL: data[UserFields.photoURL] as String?,
      dob: data[UserFields.dob] != null
          ? (data[UserFields.dob] as Timestamp).toDate()
          : null,
      lastLogin: data[UserFields.lastLogin] != null
          ? (data[UserFields.lastLogin] as Timestamp).toDate()
          : null,
      isEmailVerified: data[UserFields.isEmailVerified] ?? false,
    );
  }

  /// To Firestore JSON
  Map<String, dynamic> toJson() {
    return {
      UserFields.email: email,
      UserFields.fullName: name,
      UserFields.photoURL: photoURL,
      UserFields.profilePic: profilePic,
      UserFields.dob: dob != null ? Timestamp.fromDate(dob!) : null,
      UserFields.phoneNumber: phoneNumber,
      UserFields.lastLogin: lastLogin != null
          ? Timestamp.fromDate(lastLogin!)
          : null,
      UserFields.isEmailVerified: isEmailVerified,
    };
  }

  /// Convert to Domain Entity
  User toEntity() {
    return User(
      uid: uid,
      email: email,
      name: name,
      photoURL: photoURL,
      profilePic: profilePic,
      dob: dob,
      phoneNumber: phoneNumber,
      lastLogin: lastLogin,
      isEmailVerified: isEmailVerified,
    );
  }

  /// Create UserModel from Entity (useful for saving back to Firestore)
  factory UserModel.fromEntity(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email,
      name: user.name,
      photoURL: user.photoURL,
      profilePic: user.profilePic,
      phoneNumber: user.phoneNumber,
      dob: user.dob,
      lastLogin: user.lastLogin,
      isEmailVerified: user.isEmailVerified,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    uid,
    email,
    name,
    photoURL,
    profilePic,
    phoneNumber,
    dob,
    lastLogin,
    isEmailVerified,
  ];

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, name: $name, photoURL: $photoURL, profilePic: ${profilePic?.isNotEmpty}, phoneNumber: $phoneNumber , dob: $dob , lastLogin: $lastLogin, isEmailVerified: $isEmailVerified)';
  }
}
