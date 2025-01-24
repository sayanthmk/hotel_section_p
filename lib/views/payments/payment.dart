import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/booking_provider/booking_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:hotel_side/models/booking_model.dart';

class SortPaymentByDatePage extends StatefulWidget {
  const SortPaymentByDatePage({super.key});

  @override
  SortPaymentByDatePageState createState() => SortPaymentByDatePageState();
}

class SortPaymentByDatePageState extends State<SortPaymentByDatePage> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings by Date'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context),
          ),
        ],
      ),
      body: Consumer<BookingProvider>(
        builder: (context, bookingProvider, child) {
          // If no date selected, show all payments
          final totalPaymentsByDate = _selectedDate == null
              ? bookingProvider.getTotalPaymentsByDate()
              : _filterBookingsByDate(bookingProvider.getTotalPaymentsByDate());

          if (totalPaymentsByDate.isEmpty) {
            return Center(
              child: Text(_selectedDate == null
                  ? 'No payment records found'
                  : 'No bookings on ${DateFormat('MMMM dd, yyyy').format(_selectedDate!)}'),
            );
          }

          return Column(
            children: [
              if (_selectedDate != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Bookings on ${DateFormat('MMMM dd, yyyy').format(_selectedDate!)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Expanded(
                child: ListView.builder(
                  itemCount: totalPaymentsByDate.length,
                  itemBuilder: (context, index) {
                    final paymentRecord = totalPaymentsByDate[index];
                    final date = paymentRecord['date'];
                    final totalAmount = paymentRecord['totalPaidAmount'];
                    final bookings = paymentRecord['bookings'];

                    return ExpansionTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('MMMM dd, yyyy')
                                .format(DateTime.parse(date)),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '\$${totalAmount.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: bookings.length,
                          itemBuilder: (context, bookingIndex) {
                            final BookingSectionModel booking =
                                bookings[bookingIndex];
                            return ListTile(
                              title: Text(booking.name),
                              subtitle: Column(
                                children: [
                                  Text('Room: ${booking.roomId}'),
                                  Text('HotelId: ${booking.hotelId}'),
                                  Text(booking.userId)
                                ],
                              ),
                              trailing: Text(
                                '\$${booking.paidAmount.toStringAsFixed(2)}',
                                style: const TextStyle(color: Colors.green),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Map<String, dynamic>> _filterBookingsByDate(
      List<Map<String, dynamic>> allBookings) {
    return allBookings.where((record) {
      final recordDate = DateTime.parse(record['date']);
      return _selectedDate != null &&
          recordDate.year == _selectedDate!.year &&
          recordDate.month == _selectedDate!.month &&
          recordDate.day == _selectedDate!.day;
    }).toList();
  }
}
