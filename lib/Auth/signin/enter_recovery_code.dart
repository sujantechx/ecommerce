import 'package:ecommerce/Auth/signin/reset_passord.dart';
import 'package:ecommerce/Utils/ui_helper/button_helper.dart';
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
                    const SizedBox(height:50),

                    const Icon(Icons.email, size: 80, color: Colors.orange),
                    const SizedBox(height: 20),
                    const Text(
                      "Recovery Code Sent Successfully",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text("Please enter the recovery code we sent you."),
                    const SizedBox(height: 30),

                    const SizedBox(height: 20),

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
                    const SizedBox(height: 20),
                    UiButtonHelper().CustomButtom(callback: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) =>  ResetPasswordScreen()),
                      );
                    }, buttonName: "Recovery Account",
                        bgColor: otp.length ==6? Colors.orange:Colors.orange.shade200,
                        fgColor: Colors.white, width: double.infinity),

                    const SizedBox(height: 100),
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
