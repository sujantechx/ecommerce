// lib/models/user_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String? phone; // Phone can be optional

  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    this.phone,
  });

  // Factory constructor to create a UserModel from a Firestore document
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      fullName: data['fullName'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'],
    );
  }

  // Method to convert UserModel instance to a map for Firestore
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'createdAt': FieldValue.serverTimestamp(), // Use server timestamp
    };
  }
}