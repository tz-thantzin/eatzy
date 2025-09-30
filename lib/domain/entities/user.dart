import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String? email;
  final String? name;
  final String? photoURL;
  final Uint8List? profilePic;
  final String? phoneNumber;
  final DateTime? dob;
  final DateTime? lastLogin;
  final bool isEmailVerified;

  const User({
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

  User copyWith({
    String? uid,
    String? email,
    String? name,
    String? photoURL,
    Uint8List? profilePic,
    String? phoneNumber,
    DateTime? dob,
    DateTime? lastLogin,
    bool? isEmailVerified,
  }) {
    return User(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      photoURL: photoURL ?? this.photoURL,
      profilePic: profilePic ?? this.profilePic,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dob: dob ?? this.dob,
      lastLogin: lastLogin ?? this.lastLogin,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
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
    return 'User(uid: $uid, email: $email, name: $name, photoURL: $photoURL, profilePic: ${profilePic?.isNotEmpty},  dob: $dob , phoneNumber: $phoneNumber , lastLogin: $lastLogin, isEmailVerified: $isEmailVerified)';
  }
}

class Users {
  final List<User> users;
  final DocumentSnapshot<Map<String, dynamic>>? lastDocument;

  const Users({required this.users, required this.lastDocument});
}
