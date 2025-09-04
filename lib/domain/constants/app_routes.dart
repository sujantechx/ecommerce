import 'package:ecommerce/Auth/auth.dart';
import 'package:ecommerce/Auth/signin/login.dart';
import 'package:ecommerce/Auth/signup/sign_up.dart';
import 'package:ecommerce/Onbording/onboarding.dart';
import 'package:ecommerce/Splash/splash_screen.dart';
import 'package:ecommerce/dashbord/provider/provider_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../dashbord/dash_bord.dart';


class AppRoutes{
  static const String splash = "/";
  static const String login = "/login";
  static const String signUp = "/signup";
  static const String dashboard = "/dashboard";
  static const String intro = "/intro";
  static const String auth = "/auth";
  static const String add = "/addExp";

  static Map<String, Widget Function(BuildContext)> routes = {
    splash: (_) => SplashScreen(),
    intro: (_) => Onboarding(),
    auth: (_) => Auth(),
    login: (_) => LoginScreen(),
    signUp: (_) => SignupScreen(),
    dashboard: (_) => ChangeNotifierProvider(
      create: (context) => ProviderNav(),
      child: DashBord(),),
    // add: (_) => AddPage(),
};}