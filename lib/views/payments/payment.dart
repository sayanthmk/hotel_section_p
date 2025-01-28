import 'package:flutter/material.dart';
import 'package:hotel_side/utils/appbar/cutomappbar.dart';
import 'package:provider/provider.dart';
import 'package:hotel_side/controllers/booking_provider/booking_provider.dart';
import 'package:hotel_side/models/booking_model.dart';
import 'package:intl/intl.dart';

class SortPaymentByDatePage extends StatelessWidget {
  const SortPaymentByDatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _buildAppBar(context),
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

  // PreferredSizeWidget _buildAppBar(BuildContext context) {
  //   return AppBar(
  //     elevation: 0,
  //     backgroundColor: Theme.of(context).primaryColor,
  //     title: const Text(
  //       'Bookings by Date',
  //       style: TextStyle(fontWeight: FontWeight.w600),
  //     ),
  //     actions: [
  //       CalendarButton(onPressed: () => selectDate(context)),
  //     ],
  //   );
  // }

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

class EmptyStateWidget extends StatelessWidget {
  final DateTime? selectedDate;

  const EmptyStateWidget({super.key, this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_busy,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            selectedDate == null
                ? 'No payment records found'
                : 'No bookings on ${DateFormat('MMMM dd, yyyy').format(selectedDate!)}',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () =>
                Provider.of<BookingProvider>(context, listen: false)
                    .setSelectedDate(DateTime.now()),
            icon: const Icon(Icons.refresh),
            label: const Text('Show All Bookings'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}

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

class BookingStatusChip extends StatelessWidget {
  final String status;

  const BookingStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            size: 14,
            color: Colors.green.shade700,
          ),
          const SizedBox(width: 4),
          Text(
            status,
            style: TextStyle(
              color: Colors.green.shade700,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

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

class UserAvatar extends StatelessWidget {
  final String name;

  const UserAvatar({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          name[0].toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class PriceTag extends StatelessWidget {
  final double amount;

  const PriceTag({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.shade400,
            Colors.green.shade600,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        '₹${amount.toStringAsFixed(2)}',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

// Add this animation mixin for card animations
class BookingCardAnimation extends StatelessWidget {
  final Widget child;

  const BookingCardAnimation({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 300),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
