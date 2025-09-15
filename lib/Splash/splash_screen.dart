import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/constants/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds:2),(){
      _checkStatus();
      Navigator.pushReplacementNamed(context, AppRoutes.intro);
    });
  }
  Future<void>_checkStatus() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";

    String nextPage = AppRoutes.login;

    if(token.isNotEmpty){
      nextPage = AppRoutes.dashboard;
    }

    Navigator.pushReplacementNamed(context, nextPage);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Container(
            height: 250,width: 250 ,
            child: Image(image: AssetImage('assets/logo/splass.png'))),
      ),
    );
  }
}
