import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<bool> signup({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = ''; // Reset error message on new attempt
    notifyListeners();

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        // IMPORTANT: The await here is crucial. The app waits for the email to be sent.
        await user.sendEmailVerification();

        // After the email is sent, save user data
        await _firestore.collection('users').doc(user.uid).set({
          'fullName': fullName,
          'email': email,
          'phone': phone,
          'uid': user.uid,
          'createdAt': Timestamp.now(),
        });

        _isLoading = false;
        notifyListeners();
        return true; // Success!
      }
    } on FirebaseAuthException catch (e) {
      // If Firebase fails, set the error message
      _errorMessage = e.message ?? "An authentication error occurred.";
    } catch (e) {
      // Handle other potential errors (e.g., no internet connection)
      _errorMessage = "An unknown error occurred. Please check your connection.";
    }

    _isLoading = false;
    notifyListeners();
    return false; // Failure
  }
}