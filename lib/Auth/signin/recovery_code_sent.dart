import 'package:flutter/material.dart';

import 'enter_recovery_code.dart';

class RecoveryCodeSentScreen extends StatelessWidget {
  const RecoveryCodeSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.email, size: 80, color: Colors.green),
            const SizedBox(height: 20),
            const Text(
              "Recovery Code Sent Successfully",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text("Please enter the recovery code we sent you."),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const EnterRecoveryCodeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Enter Code"),
            ),
          ],
        ),
      ),
    );
  }
}
