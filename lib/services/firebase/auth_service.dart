// lib/services/firebase/auth_service.dart

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  Future<User?> signIn({required String email, required String password}) async {
    // No try-catch here. Let the calling method (in AuthProvider) handle it.
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  Future<User?> signUp({required String email, required String password}) async {
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = result.user;
    if (user != null) {
      // It's good practice to await this to ensure the email is sent
      // before signaling success.
      await user.sendEmailVerification();
    }
    return user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }


  /// Reloads the current user's properties to get the latest state.
  Future<void> reloadCurrentUser() async {
    await _auth.currentUser?.reload();
  }

  /// Sends a verification email to the current user.
  Future<void> sendVerificationEmail() async {
    await _auth.currentUser?.sendEmailVerification();
  }
}