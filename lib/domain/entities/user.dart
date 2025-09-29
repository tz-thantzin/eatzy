import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String? email;
  final String? name;
  final String? photo;
  final Uint8List? imageBytes;
  final DateTime? dob;
  final DateTime? lastLogin;
  final String? gender;
  final bool isEmailVerified;

  const User({
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

  User copyWith({
    String? uid,
    String? email,
    String? name,
    String? photo,
    Uint8List? imageBytes,
    DateTime? dob,
    DateTime? lastLogin,
    String? gender,
    bool? isEmailVerified,
    bool? isUserProfileExist,
  }) {
    return User(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      photo: photo ?? this.photo,
      imageBytes: imageBytes ?? this.imageBytes,
      dob: dob ?? this.dob,
      lastLogin: lastLogin ?? this.lastLogin,
      gender: gender ?? this.gender,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
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
    return 'User(uid: $uid, email: $email, name: $name, photo: $photo, imageBytes: ${imageBytes?.isNotEmpty},  dob: $dob , lastLogin: $lastLogin, gender: $gender, isEmailVerified: $isEmailVerified)';
  }
}

class Users {
  final List<User> users;
  final DocumentSnapshot<Map<String, dynamic>>? lastDocument;

  const Users({required this.users, required this.lastDocument});
}
