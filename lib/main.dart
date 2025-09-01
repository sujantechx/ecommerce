// lib/main.dart

import 'package:ecommerce/services/firebase/auth_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

// 1. Import the generated file
import 'firebase_options.dart';

// ... your other imports (AuthService, FirestoreService, etc.)
import 'package:ecommerce/services/firebase/auth_service.dart';
import 'package:ecommerce/services/firebase/firestore_service.dart';
import 'package:ecommerce/services/provider/auth_provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Use the 'options' parameter from the generated file
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<FirestoreService>(create: (_) => FirestoreService()),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(
            authService: context.read<AuthService>(),
            firestoreService: context.read<FirestoreService>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'E-commerce',
      debugShowCheckedModeBanner: false,
      home: AuthWrapper(),
    );
  }
}