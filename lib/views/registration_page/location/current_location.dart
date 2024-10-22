import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CurrentLocationSection extends StatelessWidget {
  const CurrentLocationSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: const Row(
        children: [
          Icon(
            FontAwesomeIcons.locationCrosshairs,
            color: Color(0xff1E91B6),
            size: 20,
          ),
          SizedBox(width: 12),
          Text(
            'Use Current Location',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF2D3142),
            ),
          ),
        ],
      ),
    );
  }
}
