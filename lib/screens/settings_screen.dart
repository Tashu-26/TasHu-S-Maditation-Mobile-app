
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _projectRemindersEnabled = true;
  bool _soundEnabled = true;
  bool _hapticsEnabled = true;

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 22),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: AppColors.darkBrown,
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool>? onChanged,
  }) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      activeThumbColor: AppColors.primary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14),
      secondary: Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: AppColors.cream,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.darkBrown,
          fontSize: 14,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.secondaryText,
        ),
      ),
    );
  }

  Widget _buildSettingsCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(children: children),
    );
  }

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature will be available soon.'),
        backgroundColor: AppColors.darkBrown,
      ),
    );
  }

  void _showAboutApp() {
    showAboutDialog(
      context: context,
      applicationName: 'TasHu\'S Maditation',
      applicationVersion: '1.0.0',
      applicationLegalese:
      'Your Smart Crochet Companion. Made with love for crochet lovers.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.darkBrown,
          ),
        ),
        backgroundColor: AppColors.background,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Intro card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.cream,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.settings_rounded,
                      size: 35,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Make it yours!',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkBrown,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Customize your crochet companion experience.',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Notifications
              _buildSectionTitle('Notifications'),
              _buildSettingsCard(
                children: [
                  _buildSwitchTile(
                    icon: Icons.notifications_outlined,
                    title: 'Notifications',
                    subtitle: 'Receive app notifications',
                    value: _notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _notificationsEnabled = value;
                        if (!value) {
                          _projectRemindersEnabled = false;
                        }
                      });
                    },
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _buildSwitchTile(
                    icon: Icons.alarm_outlined,
                    title: 'Project Reminders',
                    subtitle: 'Get reminders about your projects',
                    value: _projectRemindersEnabled,
                    onChanged: _notificationsEnabled
                        ? (value) {
                      setState(() {
                        _projectRemindersEnabled = value;
                      });
                    }
                        : null,
                  ),
                ],
              ),

              // App preferences
              _buildSectionTitle('App Preferences'),
              _buildSettingsCard(
                children: [
                  _buildSwitchTile(
                    icon: Icons.volume_up_outlined,
                    title: 'Sound Effects',
                    subtitle: 'Enable sounds inside the app',
                    value: _soundEnabled,
                    onChanged: (value) {
                      setState(() {
                        _soundEnabled = value;
                      });
                    },
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  _buildSwitchTile(
                    icon: Icons.vibration_outlined,
                    title: 'Haptic Feedback',
                    subtitle: 'Enable vibration feedback',
                    value: _hapticsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _hapticsEnabled = value;
                      });
                    },
                  ),
                ],
              ),

              // More options
              _buildSectionTitle('More'),
              _buildSettingsCard(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.palette_outlined,
                      color: AppColors.primary,
                    ),
                    title: const Text(
                      'Appearance',
                      style: TextStyle(
                        color: AppColors.darkBrown,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: const Text('Personalize your app theme'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      _showComingSoon('Theme customization');
                    },
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  ListTile(
                    leading: const Icon(
                      Icons.privacy_tip_outlined,
                      color: AppColors.primary,
                    ),
                    title: const Text(
                      'Privacy Policy',
                      style: TextStyle(
                        color: AppColors.darkBrown,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      _showComingSoon('Privacy Policy');
                    },
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  ListTile(
                    leading: const Icon(
                      Icons.info_outline,
                      color: AppColors.primary,
                    ),
                    title: const Text(
                      'About App',
                      style: TextStyle(
                        color: AppColors.darkBrown,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: const Text('Version 1.0.0'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _showAboutApp,
                  ),
                ],
              ),

              const SizedBox(height: 25),

              const Center(
                child: Text(
                  'TasHu\'S Maditation ♡',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
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
