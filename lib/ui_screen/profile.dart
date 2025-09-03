
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/provider/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use watch to listen for changes in AuthProvider
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.user; // Access the UserModel

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Call signOut using context.read inside a callback
              context.read<AuthProvider>().signOut();
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
            Text('Name: ${user.fullName}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text('Email: ${user.email}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text('UID: ${user.uid}', style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}