import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/booking_provider/booking_provider.dart';
import 'package:hotel_side/views/bookings/booking_detail_page.dart';
import 'package:hotel_side/views/rooms_list/widgets/states.dart';
import 'package:provider/provider.dart';

class BookingsList extends StatelessWidget {
  const BookingsList({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings List'),
      ),
      body: FutureBuilder(
        future: bookingProvider.getBookingDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingState();
          } else if (snapshot.hasError) {
            // return const ErrorState();
            // return snapshot.error;
            return Text(
              '${snapshot.error}',
              style: const TextStyle(color: Colors.grey, fontSize: 16),
              textAlign: TextAlign.center,
            );
          }
          return Consumer<BookingProvider>(
            builder: (context, provider, child) {
              final bookings = provider.bookingList;
              return ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  provider.setSelectedBooking(index);
                  final booking = bookings[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BookingDetailsPage(),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  booking.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Booking #${booking.bookId}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            _buildInfoRow(Icons.person_outline,
                                'Customer ID: ${booking.customerId}'),
                            _buildInfoRow(
                                Icons.cake_outlined, 'Age: ${booking.age}'),
                            _buildInfoRow(Icons.calendar_today,
                                'Start Date: ${booking.startdate}'),
                            _buildInfoRow(Icons.calendar_today,
                                'End Date: ${booking.enddate}'),
                            _buildInfoRow(Icons.people_outline,
                                'Adults: ${booking.numberOfAdults}'),
                            _buildInfoRow(Icons.hotel_outlined,
                                'Hotel ID: ${booking.hotelId}'),
                          ],
                        ),
                      ),
                    ),

// Helper method for consistent row styling
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

Widget _buildInfoRow(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Icon(icon, size: 16, color: Colors.blue),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
        ),
      ],
    ),
  );
}
