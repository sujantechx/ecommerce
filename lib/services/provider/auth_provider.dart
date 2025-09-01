// lib/providers/auth_provider.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/user_model.dart';
import '../firebase/auth_service.dart';
import '../firebase/firestore_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService;
  final FirestoreService _firestoreService;
  Timer? _verificationTimer;
  StreamSubscription? _authStateSubscription;

  // --- STATE VARIABLES ---
  UserModel? _user;
  bool _isLoading = true; // Start with loading true to check auth state
  String? _errorMessage;
  bool _isEmailVerified = false;
  bool _canResendEmail = false;

  // --- PUBLIC GETTERS ---
  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isEmailVerified => _isEmailVerified;
  bool get canResendEmail => _canResendEmail;

  AuthProvider({
    required AuthService authService,
    required FirestoreService firestoreService,
  })  : _authService = authService,
        _firestoreService = firestoreService {
    // Start listening to auth changes as soon as the provider is created
    listenToAuthState();
  }

  // --- HELPER METHODS ---
  void _setState({bool loading = false, String? error}) {
    _isLoading = loading;
    _errorMessage = error;
    notifyListeners();
  }

  @override
  void dispose() {
    _verificationTimer?.cancel();
    _authStateSubscription?.cancel();
    super.dispose();
  }

  // --- CORE AUTH METHODS ---

  /// Listens to the Firebase auth state and updates the UI accordingly.
  void listenToAuthState() {
    _authStateSubscription = _authService.authStateChanges.listen((User? authUser) async {
      if (authUser == null) {
        _user = null;
        _isLoading = false;
        notifyListeners();
      } else {
        // Fetch user profile from Firestore
        try {
          final userProfile = await _firestoreService.getUserProfile(authUser.uid);
          _user = userProfile;
        } catch (e) {
          _errorMessage = "Could not fetch user profile.";
        } finally {
          _isLoading = false;
          notifyListeners();
        }
      }
    });
  }

  /// Signs up a new user with email/password and creates a profile.
  Future<bool> signUp({
    required String fullName,
    required String email,
    required String password,
    String? phone,
  }) async {
    _setState(loading: true);
    try {
      final authUser = await _authService.signUp(email: email, password: password);
      if (authUser == null) throw ('User could not be created.');

      final newUser = UserModel(
        uid: authUser.uid,
        fullName: fullName,
        email: email,
        phone: phone,
      );

      await _firestoreService.setUserProfile(newUser);
      // The auth state listener will handle updating the user state automatically.
      _setState(loading: false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setState(loading: false, error: e.message);
      return false;
    } catch (e) {
      _setState(loading: false, error: e.toString());
      return false;
    }
  }

  /// Signs in an existing user.
  Future<bool> signIn({required String email, required String password}) async {
    _setState(loading: true);
    try {
      await _authService.signIn(email: email, password: password);
      // The auth state listener will handle fetching the profile and updating state.
      _setState(loading: false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setState(loading: false, error: e.message);
      return false;
    } catch (e) {
      _setState(loading: false, error: "An unknown error occurred.");
      return false;
    }
  }

  /// Signs out the current user.
  Future<void> signOut() async {
    _setState(loading: true);
    try {
      await _authService.signOut();
      // The auth state listener will clear the user state.
    } catch (e) {
      _setState(error: 'Failed to sign out.');
    } finally {
      _setState(loading: false);
    }
  }

  // --- EMAIL VERIFICATION METHODS ---

  /// Starts a periodic check for email verification status.
  void startVerificationTimer() {
    _canResendEmail = false; // Initially disable resend button
    Future.delayed(const Duration(seconds: 30), () {
      _canResendEmail = true;
      notifyListeners();
    });

    _verificationTimer = Timer.periodic(const Duration(seconds: 3), (_) async {
      await _authService.reloadCurrentUser();
      final user = _authService.currentUser;
      _isEmailVerified = user?.emailVerified ?? false;

      if (_isEmailVerified) {
        _verificationTimer?.cancel();
      }
      notifyListeners();
    });
  }

  /// Cancels the verification timer.
  void cancelVerificationTimer() {
    _verificationTimer?.cancel();
  }

  /// Resends the verification email and handles the cooldown.
  Future<void> resendVerificationEmail() async {
    if (!_canResendEmail) return;

    try {
      await _authService.sendVerificationEmail();
      _canResendEmail = false;
      notifyListeners();
      // Start cooldown timer
      Future.delayed(const Duration(seconds: 30), () {
        _canResendEmail = true;
        notifyListeners();
      });
    } catch (e) {
      _errorMessage = "Failed to resend email: ${e.toString()}";
      notifyListeners();
    }
  }
}