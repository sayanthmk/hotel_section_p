import 'package:flutter/material.dart';
import 'package:hotel_side/views/profile/profile_card.dart';
import 'package:hotel_side/views/profile/profile_edit_button.dart';
import 'package:hotel_side/views/profile/profile_header.dart';
import 'package:hotel_side/views/profile/profile_name.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProfileHeader(),

              // _buildHeader(context),
              ProfileName(),
              // _buildProfileInfo(),
              ProfileCard(),
              EditProfileSection()
            ],
          ),
        ),
      ),
    );
  }
}
