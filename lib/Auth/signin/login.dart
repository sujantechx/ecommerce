import 'package:ecommerce/Auth/signin/recovery_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';
import '../../widgets/custume_login_buttons.dart';
import '../../widgets/custume_text_field.dart';
import '../signup/sign_up.dart';
import '../signup/verify.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              const Text("Account Verified successfully",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              // Email / Phone field
              CustomTextField(
                label: "Email/Phone Number",
                controller: emailController,
                validator: (value) =>
                value!.isEmpty ? "Enter your email or phone" : null,
              ),
              const SizedBox(height: 16),

              // Password field
              CustomTextField(
                label: "Password",
                controller: passwordController,
                obscure: true,
                validator: (value) =>
                value!.isEmpty ? "Enter your password" : null,
              ),

              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(errorMessage!,
                      style: const TextStyle(color: Colors.red)),
                ),

              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const RecoveryMethodScreen()),
                    );
                  },
                  child: const Text("Forgot Password?"),
                ),
              ),
              const SizedBox(height: 10),

              // Login Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    bool success = authProvider.login(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
                    if (success) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const VerifyAccountScreen()),
                      );
                    } else {
                      setState(() {
                        errorMessage = "Invalid password";
                      });
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Login"),
              ),

              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignupScreen()),
                  );
                },
                child: const Text("Don't have an account? Sign Up"),
              ),

              const SocialLoginButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
