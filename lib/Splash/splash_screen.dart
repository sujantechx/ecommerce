import 'dart:async';

import 'package:ecommerce/Onbording/onboarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(milliseconds: 3),(){
      Navigator.push(context,
      MaterialPageRoute(builder: (context) => Onboarding(),));
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Image(image: AssetImage('assets/logo/splass.png')),
      ),
    );
  }
}
