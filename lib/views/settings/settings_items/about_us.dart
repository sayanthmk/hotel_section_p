import 'package:flutter/material.dart';
import 'package:hotel_side/utils/appbar/cutomappbar.dart';

class HotelAboutUs extends StatelessWidget {
  const HotelAboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HotelSideCustomAppbar(
        heading: 'About Us',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 5.0,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  '''StayWise Admin simplifies hotel management, making it effortless and efficient. Our powerful platform enables hotel administrators to seamlessly manage bookings, update hotel details, and oversee guest reservations with ease.
With features like real-time booking insights, streamlined approval processes, and direct communication with guests, StayWise Admin ensures a smooth operational experience. Additionally, our dedicated support system assists admins in managing properties effectively, helping them provide the best experience for their guests.
Whether you're managing a boutique hotel or a large chain, StayWise Admin is designed to enhance your workflow and optimize hotel operations.''',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500, height: 1.6),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
