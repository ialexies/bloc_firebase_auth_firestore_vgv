// ignore_for_file: public_member_api_docs, sort_constructors_first
// This file is "main.dart"
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String name;
  String email;
  String profileImage;
  int point;
  String rank;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.point,
    required this.rank,
  });

  ///
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

  ///
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
