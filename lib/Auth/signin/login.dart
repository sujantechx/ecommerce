import 'package:ecommerce/Auth/signin/recovery_method.dart';
import 'package:ecommerce/Utils/ui_helper/button_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/provider/auth_provider.dart';
import '../../widgets/custume_login_buttons.dart';
import '../../widgets/custume_text_field.dart';
import '../signup/sign_up.dart';

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
  Future<void> _loggedIn()async{
    final prefs=await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);

  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"), // <-- your image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 100,
            right: 100,
              top: 40,
              child: Container(
                height: 200,width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(image: AssetImage("assets/logo/bglog.png"),fit: BoxFit.cover)

                ),
              )
          ),

          // Bottom sheet container
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
                      const SizedBox(height: 16),
                      const Text(
                        "Account Verified to Login", //"Account Verified successfully",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
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
                          child: Text(
                            errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),

                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>  RecoveryMethodScreen()),
                            );
                          },
                          child: const Text("Forgot Password?"),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Login Button
                      UiButtonHelper().CustomButtonFlex(callback: () {
                        /*if (_formKey.currentState!.validate()) {
                          bool success = authProvider.login(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                          if (success) {
                            Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
                          } else {
                            setState(() {
                              errorMessage = "Invalid password";
                            });
                          }
                        }*/
                        _loggedIn();

                      }, buttonName: "Login"),
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
                      const SizedBox(height: 20),
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
