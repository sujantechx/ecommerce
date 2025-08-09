import 'package:ecommerce/Auth/signup/verify.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/auth_provider.dart';
import '../../widgets/custume_login_buttons.dart';
import '../../widgets/custume_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 80),
              const Text("Create Account",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              CustomTextField(
                label: "Full Name",
                controller: fullNameController,
                validator: (v) =>
                v!.isEmpty ? "Please enter your full name" : null,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: "Email Address",
                controller: emailController,
                validator: (v) => !v!.contains("@") ? "Invalid email" : null,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: "Phone Number",
                controller: phoneController,
                validator: (v) =>
                v!.length < 10 ? "Enter valid phone number" : null,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                label: "Password",
                controller: passwordController,
                obscure: true,
                validator: (v) =>
                v!.length < 6 ? "Password must be 6+ chars" : null,
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

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    authProvider.signup(
                      fullNameController.text.trim(),
                      emailController.text.trim(),
                      phoneController.text.trim(),
                      passwordController.text.trim(),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const VerifyAccountScreen()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Sign Up"),
              ),
              const SizedBox(height: 20),
              const SocialLoginButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
