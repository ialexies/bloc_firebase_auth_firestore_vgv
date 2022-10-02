// This file is "main.dart"
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'user_model.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
// part 'main.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
    required String profileImage,
    required int point,
    required String rank,
  }) = _User;

  factory User.fromDoc(DocumentSnapshot userDoc) {
    final userData = userDoc.data() as Map<String, dynamic>?;

    return User(
      id: userDoc.id,
      name: userData!['name'] as String,
      email: userData['email'] as String,
      profileImage: userData['profileImage'] as String,
      point: userData['point'] as int,
      rank: userData['rank'] as String,
    );
  }

  factory User.initialUser() {
    return User(
      id: '',
      name: '',
      email: '',
      profileImage: '',
      point: -1,
      rank: '',
    );
  }
}
