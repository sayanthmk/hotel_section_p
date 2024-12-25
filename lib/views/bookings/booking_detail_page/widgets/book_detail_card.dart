import 'package:flutter/material.dart';
import 'package:hotel_side/models/booking_model.dart';
import 'package:hotel_side/views/bookings/booking_detail_page/widgets/book_det_date.dart';
import 'package:hotel_side/views/bookings/booking_detail_page/widgets/book_det_info.dart';
import 'package:intl/intl.dart';

class BookingDetailCard extends StatelessWidget {
  const BookingDetailCard({
    super.key,
    required this.bookingDetails,
  });

  final BookingSectionModel? bookingDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Text(
                'Booking ID: ${bookingDetails?.bookId}'
                    .toUpperCase()
                    .substring(0, 23),
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            color: Colors.white,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Stay Details',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Divider(height: 32),
                  BookDetailDateRow(
                    label: 'Check-in',
                    date: DateFormat('dd MMM yyyy')
                        .format(bookingDetails!.startdate),
                    icon: Icons.login,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 20),
                  BookDetailDateRow(
                    label: 'Check-out',
                    date: DateFormat('dd MMM yyyy')
                        .format(bookingDetails!.enddate),
                    icon: Icons.logout,
                    color: Colors.red,
                  ),
                  const Divider(height: 32),
                  BookDetailInfoRow(
                    icon: Icons.people_alt_outlined,
                    label: 'Number of Adults',
                    value: bookingDetails!.numberOfAdults.toString(),
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 32),
                  BookDetailInfoRow(
                    icon: Icons.people_alt_outlined,
                    label: 'Number of Childs',
                    value: bookingDetails!.numberOfChilds.toString(),
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            color: Colors.white,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Guest Information',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Divider(height: 32),
                  BookDetailInfoRow(
                    icon: Icons.person_outline,
                    label: 'Guest Name',
                    value: bookingDetails!.name,
                    color: Colors.purple,
                  ),
                  const SizedBox(height: 16),
                  BookDetailInfoRow(
                    icon: Icons.badge_outlined,
                    label: 'Customer ID',
                    value: bookingDetails!.customerId,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 16),
                  BookDetailInfoRow(
                    icon: Icons.cake_outlined,
                    label: 'Age',
                    value: bookingDetails!.age.toString(),
                    color: Colors.teal,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
