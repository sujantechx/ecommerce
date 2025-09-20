import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/user/user_bloc.dart';
import '../bloc/user/user_event.dart';
import '../bloc/user/user_state.dart';
import '../model/user_model.dart'; // Make sure you have this import

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Dispatch the event to fetch the user profile
    context.read<UserBloc>().add(FetchUserProfileEvent());
  }

  void _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      // Use BlocBuilder to listen to UserState changes
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserFailureState) {
            return Center(child: Text('Error: ${state.errorMsg}'));
          } else if (state is UserProfileLoadedState) {
            final user = state.user;
            // Build the main UI when data is loaded
            return _buildProfileUI(context, user);
          }
          // Initial or other unhandled states
          return const Center(child: Text('Welcome to your profile!'));
        },
      ),
    );
  }

  /// Builds the main profile UI using a Stack
  Widget _buildProfileUI(BuildContext context, UserModel user) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(context, user),
          _buildAccountOverview(context),
        ],
      ),
    );
  }

  /// Builds the top green header section
  Widget _buildHeader(BuildContext context, UserModel user) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 30, left: 20, right: 20),
      decoration: const BoxDecoration(
        color: Color(0xFFE7802B),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          // Top row with Title and More Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {
                  // TODO: Implement more options functionality
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Profile Avatar and Name
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage:
                user.image.isNotEmpty ? NetworkImage(user.image) : null,
                child: user.image.isEmpty
                    ? const Icon(Icons.person, size: 50, color: Colors.white)
                    : null,
                backgroundColor: Colors.white.withOpacity(0.2),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFE88B2B), width: 2),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(Icons.edit, size: 16, color: Color(0xFFF86B09)),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          Text(
            user.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '+${user.mobileNumber}',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the list of account options
  Widget _buildAccountOverview(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Account Overview',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildMenuItem(
            icon: Icons.person_outline,
            title: 'My Profile',
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.shopping_bag_outlined,
            title: 'My Orders',
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.refresh_outlined,
            title: 'Refund',
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.lock_outline,
            title: 'Change Password',
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.language_outlined,
            title: 'Change Language',
            onTap: () {},
          ),
          const Divider(height: 30),
          _buildMenuItem(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () => _logout(context),
            isLogout: true,
          ),
        ],
      ),
    );
  }

  /// A reusable widget for each item in the account list
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    final theme = Theme.of(context);
    final color = isLogout ? Colors.red : theme.textTheme.bodyLarge?.color;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
      trailing: isLogout
          ? null
          : const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}