import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/hotel_provider/hotel_provider.dart';
import 'package:hotel_side/widgets/home_page_widgets/custom_checkbox.dart';
import 'package:provider/provider.dart';

class PolicyHeader extends StatelessWidget {
  const PolicyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff1E91B6).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hotel Policies',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xff1E91B6),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Select the policies you want to implement for your property',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class PolicyTile extends StatelessWidget {
  final String policyKey;
  final String title;
  final String subtitle;
  final IconData icon;

  const PolicyTile({
    super.key,
    required this.policyKey,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<HotelProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xff1E91B6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xff1E91B6),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          CustomCheckbox(
            value: hotelProvider.hotelData[policyKey] ?? false,
            onChanged: (value) {
              hotelProvider.updateHotelData(policyKey, value);
            },
            activeColor: const Color(0xff1E91B6),
            checkColor: Colors.white,
            size: 24.0,
          ),
        ],
      ),
    );
  }
}
