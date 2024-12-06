import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_side/models/booking_model.dart';

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
      // Clear the list to avoid duplicates.

      for (var doc in bookingsnapshot.docs) {
        log('Document Data: ${doc.data()}');
        _bookingList.add(
            BookingSectionModel.fromMap(doc.data() as Map<String, dynamic>));
        log(_bookingList.toString());
        // return bookingList;
      }
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch booking details: $e');
    }
  }
}
