// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/hotel_provider/hotel_provider.dart';
import 'package:hotel_side/views/bottom_nav/bottom_nav.dart';
import 'package:hotel_side/views/registration_page/entry_page.dart';
import 'package:provider/provider.dart';

class HotelCheckPage extends StatelessWidget {
  const HotelCheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<HotelProvider>(context, listen: false);

    Future<String?> checkHotelRegistration() async {
      return await hotelProvider.checkHotelRegistration();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String? hotelId = await checkHotelRegistration();
      if (hotelId != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const EntryRegistrationPage(),
          ),
        );
      }
    });

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
