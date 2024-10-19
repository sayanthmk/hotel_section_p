import 'package:flutter/material.dart';
import 'package:hotel_side/views/profile/profile_items.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              InfoItem(
                icon: Icons.school,
                title: 'School',
                value: 'The Lawrenceville School',
              ),
              InfoItem(
                icon: Icons.person,
                title: 'Nick Name',
                value: 'r.denial',
              ),
              InfoItem(
                icon: Icons.location_on,
                title: 'Location',
                value: 'New York, USA',
              ),
              InfoItem(
                icon: Icons.work,
                title: 'Occupation',
                value: 'Software Developer',
              ),
              InfoItem(
                icon: Icons.phone,
                title: 'Emergency Number',
                value: '+1-987654321',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
