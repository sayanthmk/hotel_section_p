import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/booking_provider/booking_provider.dart';
import 'package:hotel_side/utils/appbar/cutomappbar.dart';
import 'package:hotel_side/views/bookings/booking_detail_page/booking_detail_page.dart';
import 'package:hotel_side/views/bookings/bookings_list_page/booking_detail_view.dart';
import 'package:hotel_side/views/rooms_list/widgets/states.dart';
import 'package:provider/provider.dart';

class BookingsList extends StatelessWidget {
  const BookingsList({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const HotelSideCustomAppbar(
        heading: 'My Bookings',
      ),
      body: FutureBuilder(
        future: bookingProvider.getBookingDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingState();
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading bookings',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${snapshot.error}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return Consumer<BookingProvider>(
            builder: (context, provider, child) {
              final bookings = provider.bookingList;
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final booking = bookings[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: InkWell(
                      onTap: () {
                        provider.setSelectedBooking(index);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BookingDetailsPage(),
                          ),
                        );
                      },
                      child: BookingDetailView(booking: booking),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
