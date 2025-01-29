import 'package:flutter/material.dart';
import 'package:hotel_side/views/payments/widgets/boooking_list.dart';
import 'package:hotel_side/views/payments/widgets/status_chip.dart';

class CalendarButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CalendarButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: IconButton(
        icon: const Icon(Icons.calendar_today),
        onPressed: onPressed,
        tooltip: 'Select Date',
      ),
    );
  }
}

class BookingListView extends StatelessWidget {
  final List<Map<String, dynamic>> totalPaymentsByDate;
  final DateTime? selectedDate;

  const BookingListView({
    super.key,
    required this.totalPaymentsByDate,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    if (totalPaymentsByDate.isEmpty) {
      return EmptyStateWidget(selectedDate: selectedDate);
    }

    return Column(
      children: [
        if (selectedDate != null) DateHeader(date: selectedDate!),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: totalPaymentsByDate.length,
            itemBuilder: (context, index) {
              final paymentRecord = totalPaymentsByDate[index];
              return BookingCard(paymentRecord: paymentRecord);
            },
          ),
        ),
      ],
    );
  }
}
