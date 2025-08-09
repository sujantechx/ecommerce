import 'package:ecommerce/Auth/signin/reset_passord.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EnterRecoveryCodeScreen extends StatefulWidget {
  const EnterRecoveryCodeScreen({super.key});

  @override
  State<EnterRecoveryCodeScreen> createState() =>
      _EnterRecoveryCodeScreenState();
}

class _EnterRecoveryCodeScreenState extends State<EnterRecoveryCodeScreen> {
  String otp = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Enter Recovery Code",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            PinCodeTextField(
              appContext: context,
              length: 6,
              onChanged: (value) => otp = value,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                if (otp.length == 6) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ResetPasswordScreen()),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Recover Account"),
            ),
          ],
        ),
      ),
    );
  }
}
