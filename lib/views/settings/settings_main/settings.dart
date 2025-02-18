import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/auth_service/auth_service.dart';
import 'package:hotel_side/controllers/hotel_provider/hotel_provider.dart';
import 'package:hotel_side/utils/appbar/cutomappbar.dart';
import 'package:hotel_side/views/auth/route_page.dart';
import 'package:hotel_side/views/settings/settings_items/about_us.dart';
import 'package:hotel_side/views/settings/settings_items/contact_us.dart';
import 'package:hotel_side/views/settings/settings_items/privay_policy.dart';
import 'package:hotel_side/views/settings/settings_items/terms_conditions.dart';
import 'package:hotel_side/views/settings/settings_main/widgets/settings_haeder.dart';
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
                return const PermissionStatusWidget(
                    text: 'Hotel is Permitted', color: Colors.green);
              } else {
                return const PermissionStatusWidget(
                    text: 'Hotel is Not Permitted', color: Colors.red);
              }
            },
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                const SettingsSectionHeader(text: 'Account'),
                SettingsTile(
                  icon: Icons.lock,
                  title: 'Change Password',
                  onTap: () {},
                ),
                const Divider(height: 24, thickness: 1),
                const SettingsSectionHeader(text: 'Preferences'),
                // SettingsTile(
                //   icon: Icons.notifications,
                //   title: 'Notifications',
                //   onTap: () {},
                // ),
                // SettingsTile(
                //   icon: Icons.language,
                //   title: 'Language',
                //   onTap: () {},
                // ),
                SettingsTile(
                  icon: Icons.language,
                  title: 'Privacy Policy',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PrivacyPolicy(),
                      ),
                    );
                  },
                ),
                SettingsTile(
                  icon: Icons.language,
                  title: 'Terms&Conditions',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TermsConditions(),
                      ),
                    );
                  },
                ),
                const Divider(height: 24, thickness: 1),
                const SettingsSectionHeader(text: 'Support'),
                SettingsTile(
                  icon: Icons.help_outline,
                  title: 'Help Center',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HotelContactUsPage(),
                      ),
                    );
                  },
                ),
                SettingsTile(
                  icon: Icons.info_outline,
                  title: 'About',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HotelAboutUs(),
                      ),
                    );
                  },
                ),
                const Divider(height: 24, thickness: 1),
                SettingsTile(
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
}
