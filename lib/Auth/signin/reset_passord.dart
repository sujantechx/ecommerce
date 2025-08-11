import 'package:ecommerce/Auth/signin/reset_success.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/auth_provider.dart';
import '../../widgets/custume_text_field.dart';


class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Reset Your Password",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              CustomTextField(
                label: "Password",
                controller: passwordController,
                obscure: true,
                validator: (v) =>
                v!.length < 6 ? "Password must be at least 6 chars" : null,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: "Confirm Password",
                controller: confirmPasswordController,
                obscure: true,
                validator: (v) => v != passwordController.text
                    ? "Passwords do not match"
                    : null,
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      authProvider.resetPassword(passwordController.text.trim());
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const PasswordResetSuccessScreen()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),),
                  child: const Text("Reset Password"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
