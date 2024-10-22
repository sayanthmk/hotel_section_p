import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/field_information/hotel_provider.dart';
import 'package:hotel_side/views/registration_page/finance_information/finance_information.dart';
import 'package:hotel_side/views/registration_page/poilcy_page/widgets/policy_widgets.dart';
import 'package:hotel_side/widgets/home_page_widgets/button.dart';
import 'package:hotel_side/widgets/home_page_widgets/custom_checkbox.dart';
import 'package:provider/provider.dart';

class PoliciesPage extends StatelessWidget {
  const PoliciesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffF5F9FF),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      PolicyHeader(),
                      SizedBox(height: 24),
                      PolicyList(),
                    ],
                  ),
                ),
              ),
            ),
            BottomActionButton(),
          ],
        ),
      ),
    );
  }
}

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
          PolicyDivider(),
          PolicyTile(
            policyKey: 'couple_friendly',
            title: 'Couple Friendly',
            subtitle: 'Welcome couples with valid identification',
            icon: Icons.favorite,
          ),
          PolicyDivider(),
          PolicyTile(
            policyKey: 'parking_facility',
            title: 'Parking Facility',
            subtitle: 'Dedicated parking space for guests',
            icon: Icons.local_parking,
          ),
          PolicyDivider(),
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
