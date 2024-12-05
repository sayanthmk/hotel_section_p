import 'package:cloud_firestore/cloud_firestore.dart';

class BookingSectionModel {
  final String customerId;
  final int age;
  final Timestamp bookingDate;
  final String name;
  final int numberOfAdults;
  final String userId;

  BookingSectionModel({
    required this.customerId,
    required this.age,
    required this.bookingDate,
    required this.name,
    required this.numberOfAdults,
    required this.userId,
  });

  // Factory method to create a Booking object from Firestore data
  factory BookingSectionModel.fromMap(Map<String, dynamic> map) {
    return BookingSectionModel(
      customerId: map['cuid'] ?? '',
      age: map['age'] ?? 0,
      bookingDate: map['date'] ?? '',
      name: map['name'] ?? '',
      numberOfAdults: map['noa'] ?? 0,
      userId: map['userId'] ?? '',
    );
  }
}
