import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/booking_provider/booking_provider.dart';
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
            return const ErrorState();
          }
          return Consumer<BookingProvider>(
            builder: (context, provider, child) {
              final bookings = provider.bookingList;
              return ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final booking = bookings[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Customer ID: ${booking.customerId}'),
                          Text('Age: ${booking.age}'),
                          Text('Booking Date: ${booking.bookingDate}'),
                          Text('Name: ${booking.name}'),
                          Text('Number of Adults: ${booking.numberOfAdults}'),
                          Text('User ID: ${booking.userId}'),
                        ],
                      ),
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
