import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/hotel_provider/hotel_provider.dart';
import 'package:hotel_side/views/bottom_nav/bottom_nav.dart';
import 'package:hotel_side/views/registration_page/final_review_page/widgets/detail_card.dart';
import 'package:hotel_side/widgets/home_page_widgets/button.dart';
import 'package:provider/provider.dart';

class FinalReview extends StatelessWidget {
  const FinalReview({super.key});

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<HotelProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xffF5F9FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xff1E91B6)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(
          children: [
            Text(
              'Final Review',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
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
                child: HotelButton(
                  text: "Submit Hotel Details",
                  onTap: () {
                    hotelProvider.submitHotel().then((_) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const BottomNavScreen(),
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
                  color: const Color(0xff1E91B6),
                  textColor: Colors.white,
                  borderRadius: 12.0,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  height: 56,
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
