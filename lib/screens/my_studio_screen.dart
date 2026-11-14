
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'saved_patterns_screen.dart';
import 'settings_screen.dart';

class MyStudioScreen extends StatefulWidget {
  const MyStudioScreen({super.key});

  @override
  State<MyStudioScreen> createState() => _MyStudioScreenState();
}

class _MyStudioScreenState extends State<MyStudioScreen> {
  String _userName = 'Crochet Lover';
  String _userEmail = 'hello@example.com';

  final int _completedProjects = 4;
  final int _activeProjects = 3;
  final int _savedPatterns = 12;

  void _editProfile() {
    final nameController = TextEditingController(text: _userName);
    final emailController = TextEditingController(text: _userEmail);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          title: const Text(
            'Edit Profile',
            style: TextStyle(color: AppColors.darkBrown),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Your Name',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                nameController.dispose();
                emailController.dispose();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.trim().isEmpty ||
                    emailController.text.trim().isEmpty) {
                  return;
                }

                setState(() {
                  _userName = nameController.text.trim();
                  _userEmail = emailController.text.trim();
                });

                Navigator.pop(dialogContext);
                nameController.dispose();
                emailController.dispose();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.darkBrown,
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required int value,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: AppColors.darkBrown,
                size: 21,
              ),
            ),
            const SizedBox(height: 13),
            Text(
              '$value',
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBrown,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.secondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      color: AppColors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 5,
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.cream,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.darkBrown,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.secondaryText,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: AppColors.secondaryText,
        ),
        onTap: onTap,
      ),
    );
  }

  void _openSavedPatterns() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SavedPatternsScreen(),
      ),
    );
  }

  void _openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MY STUDIO',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 11,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Your Creative Space',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkBrown,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      _showMessage(
                        'Notifications will be available soon.',
                      );
                    },
                    icon: const Icon(
                      Icons.notifications_none_rounded,
                      color: AppColors.darkBrown,
                      size: 27,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // Profile Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.cream,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 43,
                      backgroundColor: AppColors.softPink,
                      child: Icon(
                        Icons.person_rounded,
                        size: 48,
                        color: AppColors.darkBrown,
                      ),
                    ),
                    const SizedBox(height: 13),
                    Text(
                      _userName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBrown,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _userEmail,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: _editProfile,
                      icon: const Icon(
                        Icons.edit_outlined,
                        size: 17,
                      ),
                      label: const Text('Edit Profile'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Crochet Statistics
              const Text(
                'My Crochet Journey',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                ),
              ),
              const SizedBox(height: 14),

              Row(
                children: [
                  _buildStatCard(
                    title: 'Completed',
                    value: _completedProjects,
                    icon: Icons.check_circle_outline,
                    color: AppColors.sageGreen,
                  ),
                  const SizedBox(width: 10),
                  _buildStatCard(
                    title: 'In Progress',
                    value: _activeProjects,
                    icon: Icons.pending_outlined,
                    color: AppColors.softPink,
                  ),
                  const SizedBox(width: 10),
                  _buildStatCard(
                    title: 'Saved Patterns',
                    value: _savedPatterns,
                    icon: Icons.favorite_border,
                    color: AppColors.beige,
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // Creative Space
              const Text(
                'My Creative Space',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                ),
              ),
              const SizedBox(height: 14),

              _buildMenuItem(
                icon: Icons.folder_open_outlined,
                title: 'My Projects',
                subtitle: 'View your crochet projects',
                onTap: () {
                  _showMessage(
                    'Open My Projects from the Projects tab.',
                  );
                },
              ),

              _buildMenuItem(
                icon: Icons.favorite_border,
                title: 'Saved Patterns',
                subtitle: 'Your favorite crochet patterns',
                onTap: _openSavedPatterns,
              ),

              _buildMenuItem(
                icon: Icons.inventory_2_outlined,
                title: 'My Yarn Collection',
                subtitle: 'Manage your yarn inventory',
                onTap: () {
                  _showMessage(
                    'Open your yarn collection from the Yarn Inventory feature.',
                  );
                },
              ),

              _buildMenuItem(
                icon: Icons.palette_outlined,
                title: 'Saved Color Palettes',
                subtitle: 'Your favorite color combinations',
                onTap: () {
                  _showMessage(
                    'Saved Color Palettes will be connected soon.',
                  );
                },
              ),

              const SizedBox(height: 18),

              // Account
              const Text(
                'Account',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                ),
              ),
              const SizedBox(height: 14),

              _buildMenuItem(
                icon: Icons.settings_outlined,
                title: 'Settings',
                subtitle: 'Manage your app preferences',
                onTap: _openSettings,
              ),

              _buildMenuItem(
                icon: Icons.help_outline_rounded,
                title: 'Help & Support',
                subtitle: 'Get help using TasHu\'S Maditation',
                onTap: () {
                  _showMessage(
                    'Help and Support will be available soon.',
                  );
                },
              ),

              _buildMenuItem(
                icon: Icons.info_outline_rounded,
                title: 'About App',
                subtitle: 'Learn more about TasHu\'S Maditation',
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'TasHu\'S Maditation',
                    applicationVersion: '1.0.0',
                    applicationLegalese:
                    'Your Smart Crochet Companion.',
                  );
                },
              ),

              const SizedBox(height: 20),

              const Center(
                child: Text(
                  'Made with ♡ for crochet lovers',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
