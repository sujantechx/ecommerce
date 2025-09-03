// lib/Auth/signup/verify.dart

import 'package:ecommerce/ui_screen/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Onbording/onboarding.dart';
import '../../services/provider/auth_provider.dart';

class VerifyAccountScreen extends StatefulWidget {
  const VerifyAccountScreen({super.key});

  @override
  State<VerifyAccountScreen> createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  @override
  void initState() {
    super.initState();
    // Start the verification check when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false).startVerificationTimer();
    });
  }

  @override
  void dispose() {
    // IMPORTANT: Stop the timer when the screen is closed to prevent memory leaks
    Provider.of<AuthProvider>(context, listen: false).cancelVerificationTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        // This is the magic! When the email is verified, navigate to the Home Screen.
        // This is a much better user experience than going back to the login page.
        if (authProvider.isEmailVerified) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Email successfully verified!"), backgroundColor: Colors.green),
            );
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Home()), // GO TO HOME!
                  (route) => false,
            );
          });
        }

        return Scaffold(
          body: Stack(
            // ... (Your background decoration remains the same)
            children: [
              // Your background container...
              Center(
                child: Container(
                  // ... (Your container styling remains the same)
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Verify Your Email", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      Text(
                        "A verification link has been sent to:\n${authProvider.user?.email ?? 'your email'}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 24),
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      const Text("Waiting for you to click the link...", textAlign: TextAlign.center),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.email),
                        label: const Text("Resend Email"),
                        // Button is enabled/disabled based on provider state
                        onPressed: authProvider.canResendEmail
                            ? () => authProvider.resendVerificationEmail()
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: authProvider.canResendEmail ? Colors.orange : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}