import 'package:flutter/material.dart';
import 'package:hotel_side/models/booking_model.dart';
import 'package:hotel_side/views/payments/widgets/detail_row.dart';
import 'package:hotel_side/views/payments/widgets/status_chip.dart';
import 'package:hotel_side/views/payments/widgets/user_avatar.dart';
import 'package:intl/intl.dart';

class DateHeader extends StatelessWidget {
  final DateTime date;

  const DateHeader({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 8),
          Text(
            DateFormat('MMMM dd, yyyy').format(date),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final Map<String, dynamic> paymentRecord;

  const BookingCard({super.key, required this.paymentRecord});

  @override
  Widget build(BuildContext context) {
    final date = paymentRecord['date'];
    final totalAmount = paymentRecord['totalPaidAmount'];
    final bookings = paymentRecord['bookings'];

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: BookingCardHeader(
          date: date,
          bookingsCount: bookings.length,
          totalAmount: totalAmount,
        ),
        children: [
          BookingsList(bookings: bookings),
        ],
      ),
    );
  }
}

class BookingCardHeader extends StatelessWidget {
  final String date;
  final int bookingsCount;
  final double totalAmount;

  const BookingCardHeader({
    super.key,
    required this.date,
    required this.bookingsCount,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('MMMM dd, yyyy').format(DateTime.parse(date)),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              '$bookingsCount bookings',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
        PriceTag(amount: totalAmount),
      ],
    );
  }
}

class BookingsList extends StatelessWidget {
  final List<dynamic> bookings;

  const BookingsList({super.key, required this.bookings});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final BookingSectionModel booking = bookings[index];
        return BookingListItem(booking: booking);
      },
    );
  }
}

class BookingListItem extends StatelessWidget {
  final BookingSectionModel booking;

  const BookingListItem({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 4,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserAvatar(name: booking.name),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            booking.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const BookingStatusChip(status: 'Confirmed'),
                        ],
                      ),
                    ),
                    PriceTag(amount: booking.paidAmount),
                  ],
                ),
                const SizedBox(height: 16),
                BookingDetailsCard(booking: booking),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
