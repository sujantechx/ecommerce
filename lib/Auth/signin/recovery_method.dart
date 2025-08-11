import 'package:ecommerce/Auth/signin/enter_recovery_code.dart';
import 'package:ecommerce/Auth/signup/sign_up.dart';
import 'package:flutter/material.dart';

import '../../widgets/custume_login_buttons.dart';
import '../../widgets/custume_text_field.dart';

class RecoveryMethodScreen extends StatefulWidget {
   RecoveryMethodScreen({super.key});

  @override
  State<RecoveryMethodScreen> createState() => _RecoveryMethodScreenState();
}

class _RecoveryMethodScreenState extends State<RecoveryMethodScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  String? errorMessage;

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
                        "Chose Method of Recovery", //"Account Verified successfully",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),

                      // Email / Phone field
                      CustomTextField(
                        label: "Phone Number",
                        controller: emailController,
                        validator: (value) =>
                        value!.isEmpty ? "Enter your phone" : null,
                      ),
                      const SizedBox(height: 16),

                      // Password field
                      CustomTextField(
                        label: "Email",
                        controller: passwordController,
                        obscure: true,
                        validator: (value) =>
                        value!.isEmpty ? "Enter your email" : null,
                      ),

                      const SizedBox(height: 10),


                      // Login Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => EnterRecoveryCodeScreen ()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text("Send Code"),
                      ),

                      const SizedBox(height: 20),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => SignupScreen ()),
                            );
                          },                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't receive a verification code?"),
                              SizedBox(width: 10,),
                              Text("Resend",style: TextStyle(
                                  color: Colors.green
                              ),),
                            ],
                          )),

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
