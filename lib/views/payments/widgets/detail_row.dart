import 'package:flutter/material.dart';
import 'package:hotel_side/models/booking_model.dart';

class BookingDetailsCard extends StatelessWidget {
  final BookingSectionModel booking;

  const BookingDetailsCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          DetailRowCard(
            icon: Icons.hotel,
            title: 'Room',
            value: booking.roomId,
            iconColor: Colors.blue,
          ),
          const SizedBox(height: 12),
          // DetailRowCard(
          //   icon: Icons.business,
          //   title: 'Hotel ID',
          //   value: booking.hotelId,
          //   iconColor: Colors.orange,
          // ),
          const SizedBox(height: 12),
          DetailRowCard(
            icon: Icons.person_outline,
            title: 'User ID',
            value: booking.userId,
            iconColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}

class DetailRowCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color iconColor;

  const DetailRowCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: iconColor,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ],
    );
  }
}
