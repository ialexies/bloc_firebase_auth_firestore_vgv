import 'package:authentication_repository/authentication_repository.dart'
    as my_auth_repo;
import 'package:bloc_firebase_auth_firestore_vgv/constants/db_constants.dart';
import 'package:bloc_firebase_auth_firestore_vgv/models/custom_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileRepository {
  ProfileRepository({
    required this.firebaseFirestore,
  });
  final FirebaseFirestore firebaseFirestore;

  Future<my_auth_repo.User> getProfile({required String uid}) async {
    try {
      final DocumentSnapshot userDoc = await usersRef.doc(uid).get();

      if (userDoc.exists) {
        final currentUser = my_auth_repo.User.fromDoc(userDoc);
        return currentUser;
      }

      throw 'User not found';
    } on FirebaseException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }
}
