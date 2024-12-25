import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/booking_provider/booking_provider.dart';
import 'package:hotel_side/views/bookings/booking_detail_page/widgets/book_detail_card.dart';
import 'package:provider/provider.dart';

class BookingDetailsPage extends StatelessWidget {
  const BookingDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[300],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Consumer<BookingProvider>(
        builder: (context, provider, child) {
          final bookingDetails = provider.selectedBooking;
          if (bookingDetails == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 80, color: Colors.red[300]),
                  const SizedBox(height: 24),
                  Text(
                    'Booking Details Unavailable',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please try again later',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }
          return SingleChildScrollView(
            child: BookingDetailCard(bookingDetails: bookingDetails),
          );
        },
      ),
    );
  }
}
