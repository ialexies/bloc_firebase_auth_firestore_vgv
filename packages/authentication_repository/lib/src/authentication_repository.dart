import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:firebase_auth/firebase_auth.dart';

/// Firaebause API Eception
class FirebaseAuthApiFailure implements Exception {
  ///
  const FirebaseAuthApiFailure([
    this.message = 'An unknown exception occurred',
    this.code = 'An unknown exeption code',
    this.plugin = 'An unknown plugin exception',
  ]);

  /// error message
  final String message;

  /// error code
  final String code;

  /// error plugin
  final String plugin;

  @override
  String toString() =>
      'FirebaseAuthApiFailure(message: $message, code: $code, plugin: $plugin)';
}

/// Authentication Repository

class AuthRepository {
  ///
  AuthRepository({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  ///
  final FirebaseFirestore firebaseFirestore;

  ///
  final fb_auth.FirebaseAuth firebaseAuth;

  ///
  final usersRef = FirebaseFirestore.instance.collection('user');

  ///
  Stream<fb_auth.User?> get user => firebaseAuth.userChanges();

  /// Firebase Signup
  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final signedInUser = userCredential.user!;

      await usersRef.doc(signedInUser.uid).set({
        'name': name,
        'email': email,
        'profileImage': 'https://picsum.photos/300',
        'point': 0,
        'rank': 'bronze',
      });
    } on fb_auth.FirebaseAuthException catch (e) {
      log('error in repository signup: FirebaseAuthEception \n $e');
      // throw CustomError(
      //   code: e.code,
      //   message: e.message!,
      //   plugin: e.plugin,
      // );
    } catch (e) {
      log('error in repository signup:\n $e');
      // throw CustomError(
      //   code: 'Exception',
      //   message: e.toString(),
      //   plugin: 'flutter_error/server_error',
      // );
    }
  }

  /// Signin
  Future<UserCredential?> signin({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on fb_auth.FirebaseAuthException catch (e) {
      // log('error in repository signin: FirebaseAuthEception \n $e');
      throw FirebaseAuthApiFailure(e.message.toString());
      // throw CustomError(
      //   code: e.code,
      //   message: e.message!,
      //   plugin: e.plugin,
      // );
    } catch (e) {
      // log('error in repository signin: FirebaseAuthEception \n $e');
      throw const FirebaseAuthApiFailure();

      // throw CustomError(
      //   code: 'Exception',
      //   message: e.toString(),
      //   plugin: 'flutter_error/server_error',
      // );
    }
  }

  /// Sign out
  Future<void> signout() async {
    await firebaseAuth.signOut();
  }
}
