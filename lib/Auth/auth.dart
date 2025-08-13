import 'package:ecommerce/Auth/signin/login.dart';
import 'package:ecommerce/Auth/signup/sign_up.dart';
import 'package:ecommerce/Utils/ui_helper/button_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/custume_login_buttons.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16),


                    // Login Button
                    UiButtonHelper().CustomButtonFlex(
                        callback: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen(),));
                        },
                        buttonName: "Sign Up"),
                    const SizedBox(height: 16),

                    UiButtonHelper().CustomButtonFlex(
                        callback: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                        },
                        buttonName: "Login"),
                    const SocialLoginButtons(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }
}
