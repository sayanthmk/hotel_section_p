import 'package:flutter/material.dart';
import 'package:hotel_side/views/registration_page/finance_information/finance_information.dart';
import 'package:hotel_side/views/registration_page/poilcy_page/widgets/policy_widgets.dart';
import 'package:hotel_side/widgets/home_page_widgets/button.dart';

class PolicyList extends StatelessWidget {
  const PolicyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Column(
        children: [
          PolicyTile(
            policyKey: 'free_cancel',
            title: 'Free Cancellation',
            subtitle: 'Allow free cancellation up to 24 hours before check-in',
            icon: Icons.event_available,
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFEEEEEE),
          ),
          PolicyTile(
            policyKey: 'couple_friendly',
            title: 'Couple Friendly',
            subtitle: 'Welcome couples with valid identification',
            icon: Icons.favorite,
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFEEEEEE),
          ),
          PolicyTile(
            policyKey: 'parking_facility',
            title: 'Parking Facility',
            subtitle: 'Dedicated parking space for guests',
            icon: Icons.local_parking,
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFEEEEEE),
          ),
          PolicyTile(
            policyKey: 'restaurant_facility',
            title: 'Restaurant',
            subtitle: 'In-house dining facility available',
            icon: Icons.restaurant,
          ),
        ],
      ),
    );
  }
}

class BottomActionButton extends StatelessWidget {
  const BottomActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: HotelButton(
        text: "Continue to Finance Information",
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FinanceInformation(),
          ));
        },
        color: const Color(0xff1E91B6),
        textColor: Colors.white,
        borderRadius: 12.0,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        height: 56,
        width: double.infinity,
      ),
    );
  }
}
