// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:hotel_side/models/room_model.dart';

// class RoomsProvider with ChangeNotifier {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Method to add hotel and room details
//   Future<void> addHotelAndRoom(Rooms room) async {
//     try {
//       // Step 1: Add a new hotel document to the "hotels" collection and get the generated hotelId
//       DocumentReference hotelRef = await _firestore.collection('hotels').add({
//         // 'name': 'New Hotel', // Add other hotel-specific fields here (e.g., name, address, etc.)
//         // 'location': 'City Center', // Sample field
//         // Add more fields relevant to the hotel as needed
//       });

//       // The ID of the newly created hotel document
//       String hotelId = hotelRef.id;

//       // Step 2: Now use this hotelId to add room details to the "rooms" subcollection
//       CollectionReference roomsRef = hotelRef.collection('rooms');

//       // Add the room details to the "rooms" subcollection
//       await roomsRef.add(room.addrooms());

//       // Notify listeners for any UI updates if necessary
//       notifyListeners();
//     } catch (e) {
//       throw Exception("Failed to add hotel and room details: $e");
//     }
//   }
// }
