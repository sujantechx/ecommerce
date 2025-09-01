// lib/widgets/auth_wrapper.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/Auth/signin/login.dart';
import 'package:ecommerce/Auth/signup/verify.dart';

import '../../Onbording/onboarding.dart';
import '../../Splash/splash_screen.dart';


class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      // Listen directly to Firebase's auth state changes stream
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // 1. While the connection is loading, show a splash screen
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }

        // 2. If the snapshot has data, it means the user is logged in
        if (snapshot.hasData) {
          final user = snapshot.data!;
          // Check if the user's email is verified
          if (user.emailVerified) {
            // If verified, go to the Home Screen
            return const HomeScreen();
          } else {
            // If not verified, go to the Verify Screen
            return const VerifyAccountScreen();
          }
        }

        // 3. If there's no data, the user is not logged in
        return const LoginScreen();
      },
    );
  }
}