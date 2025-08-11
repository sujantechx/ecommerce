import 'package:flutter/material.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Text("Or", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 30),

        // Apple
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            icon: Image.asset(
              "assets/logo/apple-logo.png",
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
            label: const Text("Continue with Apple"),
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Facebook
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            icon: Image.asset(
              "assets/logo/facebook.png",
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
            label: const Text("Continue with Facebook"),
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Google
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            icon: Image.asset(
              "assets/logo/google.png",
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
            label: const Text("Continue with Google"),
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
 