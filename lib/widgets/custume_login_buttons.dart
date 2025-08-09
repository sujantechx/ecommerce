import 'package:flutter/material.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Text("Or", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          icon: const Icon(Icons.apple),
          label: const Text("Continue with Apple"),
          onPressed: () {},
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.facebook),
          label: const Text("Continue with Facebook"),
          onPressed: () {},
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.g_mobiledata),
          label: const Text("Continue with Google"),
          onPressed: () {},
        ),
      ],
    );
  }
}
