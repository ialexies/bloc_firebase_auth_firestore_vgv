// ignore_for_file: public_member_api_docs, sort_constructors_first
// This file is "main.dart"
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String firstName;
  String? lastName;
  String email;
  String? age;
  String profileImage;
  int point;
  String rank;
  User({
    required this.id,
    required this.firstName,
    this.lastName,
    required this.email,
    this.age,
    required this.profileImage,
    required this.point,
    required this.rank,
  });

  ///
  factory User.fromDoc(DocumentSnapshot userDoc) {
    final userData = userDoc.data() as Map<String, dynamic>?;

    return User(
      id: userDoc.id,
      firstName: userData!['firstName'] as String,
      lastName: userData['lastName'] as String?,
      email: userData['email'] as String,
      age: userData['age'] as String?,
      profileImage: userData['profileImage'] as String,
      point: userData['point'] as int,
      rank: userData['rank'].toString(),
    );
  }

  ///
  factory User.initialUser() {
    return User(
      id: '',
      firstName: '',
      lastName: '',
      email: '',
      age: '',
      profileImage: '',
      point: -1,
      rank: '',
    );
  }
}
