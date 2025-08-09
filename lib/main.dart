import 'package:ecommerce/Splash/splash_screen.dart';
import 'package:ecommerce/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child:  MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'E-commerce',
      home:SplashScreen() ,
      debugShowCheckedModeBanner: false,
    );
  }
}