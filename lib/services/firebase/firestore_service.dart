// lib/services/firebase/firestore_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _userCollection = 'users';

  // Create or update a user profile using the UserModel
  Future<void> setUserProfile(UserModel user) async {
    try {
      await _db.collection(_userCollection).doc(user.uid).set(user.toJson());
    } on FirebaseException catch (e) {
      // Re-throw a more specific error for the provider to catch
      throw 'Firestore Error: ${e.message}';
    }
  }

  // Fetch a user profile and return it as a UserModel
  Future<UserModel?> getUserProfile(String uid) async {
    try {
      final doc = await _db.collection(_userCollection).doc(uid).get();
      if (doc.exists) {
        return UserModel.fromFirestore(doc);
      }
      return null;
    } on FirebaseException catch (e) {
      throw 'Firestore Error: ${e.message}';
    }
  }
}