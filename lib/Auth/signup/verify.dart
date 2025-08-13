import 'package:ecommerce/Utils/ui_helper/button_helper.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../signin/login.dart';

class VerifyAccountScreen extends StatefulWidget {
  const VerifyAccountScreen({super.key});

  @override
  State<VerifyAccountScreen> createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  String otp = "";

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
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50,),

                    const Text(
                      "Verify Your Account",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text("We just sent a verification code to email"),
                    const SizedBox(height: 20),

                    // OTP field
                    PinCodeTextField(
                      appContext: context,
                      length: 6,
                      onChanged: (value) {
                        setState(() {
                          otp = value;
                        });
                      },
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    TextButton(onPressed: (){},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't receive a verification code?"),
                            SizedBox(width: 10,),
                            Text("Resend",style: TextStyle(
                                color: Colors.green
                            ),),
                          ],
                        )),

                    SizedBox(
                      width: double.infinity,
                      child: UiButtonHelper().CustomButtom(
                          callback: () {
                            otp.length == 6?() {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => const LoginScreen()),
                              );
                            }:null;
                          },
                          buttonName: "Verify",
                          bgColor: otp.length ==6? Colors.orange:Colors.orange.shade200,
                          fgColor: Colors.white, width: double.infinity
                      )


                    ),

                    SizedBox(height: 200,)
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
