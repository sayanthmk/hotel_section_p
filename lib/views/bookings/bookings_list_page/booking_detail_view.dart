import 'package:flutter/material.dart';
import 'package:hotel_side/models/booking_model.dart';
import 'package:hotel_side/views/bookings/bookings_list_page/booking_header.dart';
import 'package:intl/intl.dart';

class BookingDetailView extends StatelessWidget {
  const BookingDetailView({
    super.key,
    required this.booking,
  });

  final BookingSectionModel booking;

  @override
  Widget build(BuildContext context) {
    String startdate = DateFormat('dd MMM yyyy').format(booking.startdate);
    String enddate = DateFormat('dd MMM yyyy').format(booking.enddate);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          BookingContainer(booking: booking),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Check-in',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            startdate,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 1,
                      color: Colors.grey[300],
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Check-out',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            enddate,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: BookingInfoItem(
                              icon: Icons.person_outline,
                              label: 'Childs',
                              value: booking.numberOfChilds.toString(),
                              color: Colors.blue,
                            ),
                          ),
                          Expanded(
                            child: BookingInfoItem(
                              icon: Icons.cake_outlined,
                              label: 'Age',
                              value: booking.age.toString(),
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: BookingInfoItem(
                              icon: Icons.people_outline,
                              label: 'Adults',
                              value: booking.numberOfAdults.toString(),
                              color: Colors.purple,
                            ),
                          ),
                          Expanded(
                            child: BookingInfoItem(
                              icon: Icons.hotel_outlined,
                              label: 'Customer ID',
                              value: booking.customerId
                                  .toUpperCase()
                                  .substring(14),
                              color: Colors.teal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
