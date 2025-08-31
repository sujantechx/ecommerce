import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/provider/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the AuthProvider using Consumer for rebuilding
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        // Get the user data from the provider
        final user = authProvider.user;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  // Call the signOut method from the provider
                  authProvider.signOut();
                  // AuthWrapper will automatically handle navigation
                },
              ),
            ],
          ),
          body: authProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : user == null
              ? const Center(child: Text('Not logged in.'))
              : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${user.name}', style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 10),
                Text('Email: ${user.email}', style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 10),
                Text('UID: ${user.uid}', style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        );
      },
    );
  }
}