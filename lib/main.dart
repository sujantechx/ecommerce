import 'package:ecommerce/Utils/app_routs/app_routes.dart';
import 'package:ecommerce/services/firebase/auth_service.dart';
import 'package:ecommerce/services/firebase/firestore_service.dart';
import 'package:ecommerce/services/provider/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp (
    MultiProvider(
      providers: [
        // Provide a single instance of your services
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<FirestoreService>(create: (_) => FirestoreService()),

        // Create the AuthProvider which depends on the services above
        ChangeNotifierProxyProvider2<AuthService, FirestoreService, AuthProvider>(
          create: (context) => AuthProvider(
            authService: Provider.of<AuthService>(context, listen: false),
            firestoreService: Provider.of<FirestoreService>(context, listen: false),
          ),
          update: (_, authService, firestoreService, authProvider) =>
          authProvider!..updateDependencies(authService, firestoreService),
        ),      ],
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
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}