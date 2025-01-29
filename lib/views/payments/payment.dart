import 'package:flutter/material.dart';
import 'package:hotel_side/utils/appbar/cutomappbar.dart';
import 'package:hotel_side/views/payments/widgets/calender.dart';
import 'package:provider/provider.dart';
import 'package:hotel_side/controllers/booking_provider/booking_provider.dart';

class SortPaymentByDatePage extends StatelessWidget {
  const SortPaymentByDatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HotelSideCustomAppbar(
        heading: 'Bookings by Date',
        appbaractions: [
          CalendarButton(onPressed: () => selectDate(context)),
        ],
      ),
      body: Consumer<BookingProvider>(
        builder: (context, bookingProvider, child) {
          final selectedDate = bookingProvider.selectedDate;
          final totalPaymentsByDate = selectedDate == null
              ? bookingProvider.getTotalPaymentsByDate()
              : filterBookingsByDate(
                  bookingProvider.getTotalPaymentsByDate(),
                  selectedDate,
                );

          return BookingListView(
            totalPaymentsByDate: totalPaymentsByDate,
            selectedDate: selectedDate,
          );
        },
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: bookingProvider.selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      bookingProvider.setSelectedDate(picked);
    }
  }

  List<Map<String, dynamic>> filterBookingsByDate(
      List<Map<String, dynamic>> allBookings, DateTime selectedDate) {
    return allBookings.where((record) {
      final recordDate = DateTime.parse(record['date']);
      return recordDate.year == selectedDate.year &&
          recordDate.month == selectedDate.month &&
          recordDate.day == selectedDate.day;
    }).toList();
  }
}
