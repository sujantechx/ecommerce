import 'package:firebase_auth/firebase_auth.dart';
// Import Firestore service with a prefix to avoid name conflicts
import 'package:ecommerce/services/firebase/firestore_service.dart' as fs;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final fs.FirestoreService _firestoreService = fs.FirestoreService();

  /// Stream to listen for authentication state changes.
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Get the current logged-in user.
  User? get currentUser => _auth.currentUser;

  /// Sign in with email and password.
  Future<User?> signIn({required String email, required String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      print('Sign In Error: ${e.message}');
      return null;
    }
  }

  /// Sign up with email and password, then create a user profile in Firestore.
  Future<User?> signUp({
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (user != null) {
        // After creating the auth user, create their profile in Firestore
        await _firestoreService.createUserProfile(
          uid: user.uid,
          name: name,
          email: email,
          phone: phone,
        );
        await user.sendEmailVerification();
      }
      return user;
    } on FirebaseAuthException catch (e) {
      print('Sign Up Error: ${e.message}');
      return null;
    }
  }

  /// Sign out the current user.
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Sign Out Error: $e');
    }
  }
}