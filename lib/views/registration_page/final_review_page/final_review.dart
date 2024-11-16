import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/field_information/hotel_provider.dart';
import 'package:hotel_side/views/bottom_nav/bottom_nav.dart';
import 'package:hotel_side/views/registration_page/final_review_page/widgets/detail_card.dart';
import 'package:provider/provider.dart';

class FinalReview extends StatelessWidget {
  const FinalReview({super.key});

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<HotelProvider>(context);
    final hotelData = hotelProvider.hotelData;

    return Scaffold(
      backgroundColor: const Color(0xffF5F9FF),
      appBar: AppBar(
        elevation: 0,
        title: const Text('Final Review'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DetailFinalReviewCard(),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    log('Hotel Type: ${hotelData['hotel_type']}');
                    log('Property Setup: ${hotelData['property_setup']}');
                    log('Contact Number: ${hotelData['info']?['contact_number']}');
                    log('State: ${hotelData['location']?['state']}');

                    hotelProvider.submitHotel().then((_) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BottomNavScreen(),
                      ));
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error: $error'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Submit Hotel Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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


 