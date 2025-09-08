import 'package:ecommerce/Auth/signin/recovery_method.dart';
import 'package:ecommerce/bloc/user/user_bloc.dart';
import 'package:ecommerce/bloc/user/user_event.dart';
import 'package:ecommerce/bloc/user/user_state.dart';
import 'package:ecommerce/domain/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool isLoading = false;


   Future<void> _loggedIn()async{
    final prefs=await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);

  }

  @override
  Widget build(BuildContext context) {

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
                      // No more 'isLoading' variable needed here!

                      BlocConsumer<UserBloc, UserState>(
                        // The listener is for "side effects" like showing a SnackBar.
                        // It should NOT be used to set state that affects the UI build.
                        listener: (context, state) {
                          if (state is UserFailureState) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(state.errorMsg),
                              backgroundColor: Colors.red,
                            ));
                          } else if (state is UserSuccessState) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Login successfully"),
                              backgroundColor: Colors.green,
                            ));
                            // You might also want to navigate to the home screen here
                            Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
                            _loggedIn();

                          }
                        },
                        // The builder's only job is to build the UI based on the current state.
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () {
                              // Don't do anything if the state is already loading
                              if (state is UserLoadingState) return;

                              if (_formKey.currentState!.validate()) {
                                String email = emailController.text;
                                String pass = passwordController.text;
                                context.read<UserBloc>().add(
                                  LoginUserEvent(email: email, pass: pass),
                                );
                              }
                            },
                            // The child of the button is now determined directly by the state.
                            // This is the correct way to use the builder.
                            child: (state is UserLoadingState)
                                ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                                  child: CircularProgressIndicator(color: Colors.white),
                                ),
                                SizedBox(width: 11),
                                Text("Logging in..."),
                              ],
                            )
                                : Text("Login"), // Show "Login" for all other states
                          );
                        },
                      ),
                      // Login Button
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
