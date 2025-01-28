import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/auth_service/auth_service.dart';
import 'package:hotel_side/controllers/hotel_provider/hotel_provider.dart';
import 'package:hotel_side/utils/appbar/cutomappbar.dart';
import 'package:hotel_side/views/auth/route_page.dart';
import 'package:hotel_side/widgets/home_page_widgets/alert_box.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final hotelProvider = Provider.of<HotelProvider>(context, listen: false);

    return Scaffold(
      appBar: const HotelSideCustomAppbar(heading: 'Settings'),
      body: Column(
        children: [
          FutureBuilder<String?>(
            future: hotelProvider.hotelPermission(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.data != null) {
                return _buildPermissionStatus(
                    'Hotel is Permitted', Colors.green);
              } else {
                return _buildPermissionStatus(
                    'Hotel is Not Permitted', Colors.red);
              }
            },
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildSectionHeader('Account'),
                _buildSettingsTile(
                  icon: Icons.person,
                  title: 'Profile',
                  onTap: () {
                    // Navigate to Profile
                  },
                ),
                _buildSettingsTile(
                  icon: Icons.lock,
                  title: 'Change Password',
                  onTap: () {
                    // Navigate to Change Password
                  },
                ),
                const Divider(height: 24, thickness: 1),
                _buildSectionHeader('Preferences'),
                _buildSettingsTile(
                  icon: Icons.notifications,
                  title: 'Notifications',
                  onTap: () {
                    // Navigate to Notifications
                  },
                ),
                _buildSettingsTile(
                  icon: Icons.language,
                  title: 'Language',
                  onTap: () {
                    // Navigate to Language Settings
                  },
                ),
                const Divider(height: 24, thickness: 1),
                _buildSectionHeader('Support'),
                _buildSettingsTile(
                  icon: Icons.help_outline,
                  title: 'Help Center',
                  onTap: () {
                    // Navigate to Help Center
                  },
                ),
                _buildSettingsTile(
                  icon: Icons.info_outline,
                  title: 'About',
                  onTap: () {
                    // Navigate to About
                  },
                ),
                const Divider(height: 24, thickness: 1),
                _buildSettingsTile(
                  icon: Icons.exit_to_app,
                  title: 'Logout',
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (context) => CustomAlertDialog(
                        titleText: 'Logout',
                        contentText: 'Are you sure you want to Logout?',
                        buttonText1: 'No',
                        buttonText2: 'Yes',
                        onPressButton1: () {
                          Navigator.of(context).pop();
                        },
                        onPressButton2: () async {
                          await authService.signOut();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const AuthSelectionPage(),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionStatus(String text, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.arrow_forward_ios,
            size: 16, color: Colors.blueAccent),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
