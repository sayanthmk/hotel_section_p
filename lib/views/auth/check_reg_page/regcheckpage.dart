import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/auth_service/auth_service.dart';
import 'package:hotel_side/controllers/field_information/hotel_provider.dart';
import 'package:hotel_side/views/registration_page/entry_page.dart';
import 'package:hotel_side/views/registration_page/success_screen.dart';
import 'package:provider/provider.dart';

class HotelCheckPage extends StatelessWidget {
  const HotelCheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<HotelProvider>(context);
    final authService = Provider.of<AuthService>(context);

    // Check the hotel registration status using FutureBuilder
    Future<String?> _checkHotelRegistration() async {
      return await hotelProvider.checkHotelRegistration();
    }

    // Automatically navigate based on the hotel registration status
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String? hotelId = await _checkHotelRegistration();
      if (hotelId != null) {
        // Navigate to SuccessScreen if the hotel is registered
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessScreen(),
          ),
        );
      } else {
        // Navigate to EntryRegistrationPage if the hotel is not registered
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const EntryRegistrationPage(),
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Check Hotel Registration'),
      ),
      body: const Center(
        child: CircularProgressIndicator(), // Show loading indicator
      ),
      bottomNavigationBar: ElevatedButton(
        child: const Text('Sign Out'),
        onPressed: () async {
          await authService.signOut();
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
