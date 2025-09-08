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
      _chackeStatus();
      Navigator.pushReplacementNamed(context, AppRoutes.intro);
    });
  }
  Future<void>_chackeStatus()async{
    final prefs=await SharedPreferences.getInstance();
    bool isFirstTime=prefs.getBool('isFirstTime')??true;
    bool isLoggedIn=prefs.getBool('isLoggedIn')??false;
  if(isLoggedIn){
    Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
  }
  else if(isFirstTime){
    Navigator.pushReplacementNamed(context, AppRoutes.intro);
  }else{
    Navigator.pushReplacementNamed(context, AppRoutes.auth);
  }

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
