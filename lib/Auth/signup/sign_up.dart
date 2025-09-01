import 'package:ecommerce/Auth/signup/verify.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/provider/auth_provider.dart';
import '../../widgets/custume_login_buttons.dart';


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
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    bool success = await authProvider.signUp(
      fullName: fullNameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (mounted && success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const VerifyAccountScreen()),
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.errorMessage??"An unknown error occurred."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 100,
            right: 100,
            top: 40,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: const DecorationImage(
                  image: AssetImage("assets/logo/bglog.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Create Account",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: fullNameController,
                        decoration: const InputDecoration(labelText: "Full Name"),
                        validator: (v) => v!.isEmpty ? "Please enter your full name" : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(labelText: "Email Address"),
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) => !v!.contains("@") ? "Invalid email" : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: phoneController,
                        decoration: const InputDecoration(labelText: "Phone Number"),
                        keyboardType: TextInputType.phone,
                        validator: (v) => v!.length < 10 ? "Enter valid phone number" : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(labelText: "Password"),
                        obscureText: true,
                        validator: (v) => v!.length < 6 ? "Password must be 6+ characters" : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: confirmPasswordController,
                        decoration: const InputDecoration(labelText: "Confirm Password"),
                        obscureText: true,
                        validator: (v) => v != passwordController.text ? "Passwords do not match" : null,
                      ),
                      const SizedBox(height: 20),
                      Consumer<AuthProvider>(
                        builder: (context, provider, child) {
                          return provider.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _handleSignUp,
                              child: const Text("Sign Up"),
                            ),
                          );
                        },
                      ),
                      const SocialLoginButtons()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}