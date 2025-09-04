import 'package:ecommerce/domain/constants/app_routes.dart';
import 'package:flutter/material.dart';


void main()  {
  runApp( MyApp(),
  );
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'E-commerce',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash,
        routes:AppRoutes.routes ,
    );
  }
}