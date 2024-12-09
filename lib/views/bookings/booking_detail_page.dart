import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/booking_provider/booking_provider.dart';
import 'package:provider/provider.dart';

class BookingDetailsPage extends StatelessWidget {
  const BookingDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
        centerTitle: true,
      ),
      body: Consumer<BookingProvider>(
        builder: (context, provider, child) {
          final bookingDetails = provider.selectedBooking;
          if (bookingDetails == null) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 60, color: Colors.red),
                  SizedBox(height: 16),
                  Text(
                    'Booking Details Unavailable',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailCard(context, bookingDetails),
                const SizedBox(height: 16),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailCard(BuildContext context, dynamic bookingDetails) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                bookingDetails.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 16),
            _buildDetailRow(
                Icons.person_outline, 'Customer ID', bookingDetails.customerId),
            _buildDetailRow(
                Icons.cake_outlined, 'Age', bookingDetails.age.toString()),
            _buildDetailRow(Icons.calendar_today, 'Start Date',
                bookingDetails.startdate.toString()),
            _buildDetailRow(Icons.calendar_today, 'End Date',
                bookingDetails.enddate.toString()),
            _buildDetailRow(Icons.people_outline, 'Adults',
                bookingDetails.numberOfAdults.toString()),
            _buildDetailRow(Icons.numbers, 'Booking ID', bookingDetails.bookId),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 20),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
