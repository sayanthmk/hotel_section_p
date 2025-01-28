import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_side/models/booking_model.dart';
import 'package:intl/intl.dart';

class BookingProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  final List<BookingSectionModel> _bookingList = [];
  List<BookingSectionModel> get bookingList => _bookingList;

  Future<dynamic> getBookingDetails() async {
    if (userId == null) {
      throw Exception('No user is logged in.');
    }

    try {
      QuerySnapshot bookingsnapshot = await _firestore
          .collection('approved_hotels')
          .doc(userId)
          .collection('bookings')
          .get();

      _bookingList.clear();

      for (var doc in bookingsnapshot.docs) {
        // log('Document Data: ${doc.data()}');
        _bookingList.add(
            BookingSectionModel.fromMap(doc.data() as Map<String, dynamic>));
        // log(_bookingList.toString());
        // return bookingList;
      }
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch booking details: $e');
    }
  }

  Future<double> getPaymentTotal() async {
    if (userId == null) {
      throw Exception('No user is logged in.');
    }

    try {
      // Fetch all booking documents for the user
      QuerySnapshot bookingSnapshot = await _firestore
          .collection('approved_hotels')
          .doc(userId)
          .collection('bookings')
          .get();

      double totalPaidAmount = bookingSnapshot.docs.fold(
        0.0,
        (sumofpaidamount, doc) {
          final bookingDetails = doc.data() as Map<String, dynamic>;
          final paidAmount =
              (bookingDetails['bookingDetails']?['paidAmount'] ?? 0) as num;
          return sumofpaidamount + paidAmount.toDouble();
        },
      );

      notifyListeners();
      // log(totalPaidAmount.toString());
      return totalPaidAmount;
    } catch (e) {
      throw Exception('Failed to fetch booking details: $e');
    }
  }

  /// List payments grouped by booking date
  Map<String, List<BookingSectionModel>> getPaymentsGroupedByBookingDate() {
    // Create a map to store bookings grouped by date
    Map<String, List<BookingSectionModel>> groupedPayments = {};

    for (var booking in _bookingList) {
      // Format the booking date to 'yyyy-MM-dd' to group by day
      String formattedDate =
          DateFormat('yyyy-MM-dd').format(booking.bookingDate);

      // Add booking to the appropriate group
      if (groupedPayments.containsKey(formattedDate)) {
        groupedPayments[formattedDate]!.add(booking);
      } else {
        groupedPayments[formattedDate] = [booking];
      }
    }

    return groupedPayments;
  }

  /// Display total payments for each date
  List<Map<String, dynamic>> getTotalPaymentsByDate() {
    final groupedPayments = getPaymentsGroupedByBookingDate();

    // Create a list of total payments per date
    return groupedPayments.entries.map((entry) {
      double totalAmount =
          entry.value.fold(0.0, (sum, booking) => sum + booking.paidAmount);

      return {
        'date': entry.key,
        'totalPaidAmount': totalAmount,
        'bookings': entry.value,
      };
    }).toList();
  }

  int? _selectedBookingIndex;
  BookingSectionModel? _selectedBooking;

  int? get selectedBookingIndex => _selectedBookingIndex;
  BookingSectionModel? get selectedBooking => _selectedBooking;

  void setSelectedBooking(int index) {
    if (index >= 0 && index < _bookingList.length) {
      _selectedBookingIndex = index;
      _selectedBooking = _bookingList[index];
      // notifyListeners();
    }
  }

  void clearSelectedBooking() {
    _selectedBookingIndex = null;
    _selectedBooking = null;
    notifyListeners();
  }

  DateTime? _bookingSelectedDate;

  DateTime? get selectedDate => _bookingSelectedDate;

  void setSelectedDate(DateTime date) {
    _bookingSelectedDate = date;
    notifyListeners();
  }
}
