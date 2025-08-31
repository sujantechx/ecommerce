// lib/services/firebase/firestore_service.dart

import 'package:cloud_firestore/cloud_firestore.dart' as fs;

class FirestoreService {
  final fs.FirebaseFirestore _db = fs.FirebaseFirestore.instance;

  Future<void> createUserProfile({required String uid, required String name, required String email, String? phone}) {
    return _db.collection('users').doc(uid).set({
      'name': name,
      'email': email,
    });
  }

  Future<fs.DocumentSnapshot> getUserProfile(String uid) {
    return _db.collection('users').doc(uid).get();
  }

// Add more functions here for fetching products, orders, etc.
}