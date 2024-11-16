import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RoomProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final Map<String, dynamic> roomData = {
    "room_area": '',
    "room_type": '',
    "Property Size": 0,
    "Select Extra Bed Types": 0,
    "Cupboard": false,
    "Wardrobe": false,
    "Free Breakfast": false,
    "Free Lunch": false,
    "Free Dinner": false,
    "Base Price": 0,
    "Number of Extra Adults Allowed": 0,
    "Number of Extra Child Allowed": 0,
    "Laundry": false,
    "Elevator": false,
    "Air Conditioner": false,
    "House Keeping": false,
    "Kitchen": false,
    "Wifi": false,
    "Parking": false,
    'room_images': [],
  };

  final List<File> _roomImages = [];
  final List<String> _roomImageUrls = [];
  final List<Map<String, dynamic>> _roomList = []; // Initialize the room list
  bool _isUploading = false;
  bool get isUploading => _isUploading;
  String? hotelId;

  List<File> get roomImages => _roomImages;
  List<String> get roomImageUrls => _roomImageUrls;
  List<Map<String, dynamic>> get roomList => _roomList; // Getter for roomList
  bool get isRoomUploading => _isUploading;

  void updateRoomData(String field, dynamic value) {
    roomData[field] = value;
    notifyListeners();
    log('Room data updated: $field = $value');
  }

  Future<void> pickRoomImages() async {
    final pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      // pickedFiles != null &&
      _roomImages.addAll(pickedFiles.map((file) => File(file.path)));
      notifyListeners();
    }
  }

  Future<void> captureRoomImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _roomImages.add(File(pickedFile.path));
      notifyListeners();
    }
  }

  void removeRoomImage(int index) {
    if (index >= 0 && index < _roomImages.length) {
      _roomImages.removeAt(index);
      notifyListeners();
    }
  }

  Future<bool> uploadRoomImages() async {
    if (_roomImages.isEmpty) return false;

    _isUploading = true;
    notifyListeners();

    try {
      for (var image in _roomImages) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('room_images/${DateTime.now().toString()}');
        final uploadTask = ref.putFile(image);
        final snapshot = await uploadTask.whenComplete(() {});
        final url = await snapshot.ref.getDownloadURL();
        _roomImageUrls.add(url);
      }
      _isUploading = false;
      _roomImages.clear();
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error uploading room images: $e');
      _isUploading = false;
      notifyListeners();
      return false;
    }
  }

  void clearRoomImages() {
    _roomImages.clear();
    _roomImageUrls.clear();
    notifyListeners();
  }

  Future<void> submitRoom() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? hotelId =
    //     prefs.getString('hotelId'); // Load hotelId from SharedPreferences
    // log("room function hotel id$hotelId!");
    try {
      // Fetch the userId of the current user (this will be the document ID in the 'hotels' collection)
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Retrieve the document for this user (hotel)
      DocumentSnapshot hotelDoc =
          await _firestore.collection('approved_hotels').doc(userId).get();

      // Check if the document exists and has data
      if (!hotelDoc.exists) {
        log('Hotel document does not exist for userId: $userId');
        throw Exception(
            'Hotel document does not exist. Please submit the hotel first.');
      }

      // Extract the hotelId from the document's data (assuming hotelId is a field in the document)
      String? hotelId = userId;

      if (_roomImageUrls.isNotEmpty) {
        roomData['room_images'] = _roomImageUrls;
      }

      DocumentReference roomRef = await _firestore
          .collection('approved_hotels')
          .doc(hotelId)
          .collection('rooms')
          .add(roomData);
      // Get the room ID from the document reference
      String roomId = roomRef.id;

      // Update the room data with the room ID
      await roomRef.update({'room_id': roomId});

      log('Room added to hotel with ID: $hotelId, Room ID: $roomId');

      log('Room added to hotel with ID: $hotelId');
      clearRoomImages();
    } catch (e) {
      debugPrint('Error adding room: $e');
    }
  }

  Future<void> getRooms() async {
    try {
      // Fetch the userId of the current user (this will be the document ID in the 'hotels' collection)
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Retrieve the document for this user (hotel)
      DocumentSnapshot hotelDoc =
          await _firestore.collection('approved_hotels').doc(userId).get();

      // Check if the document exists and has data
      if (!hotelDoc.exists) {
        log('Hotel document does not exist for userId: $userId');
        throw Exception(
            'Hotel document does not exist. Please submit the hotel first.');
      }

      // Extract the hotelId from the document's data (assuming hotelId is a field in the document)
      String? hotelId =
          userId; // Adjust the key based on your Firestore document structure

      log('Hotel ID fetched: $hotelId');

      // Fetch rooms from Firestore where the hotelId matches
      QuerySnapshot roomSnapshot = await _firestore
          .collection('approved_hotels')
          .doc(hotelId)
          .collection('rooms')
          .get();

      // Clear any previous room data
      _roomList.clear();

      // Add the rooms to the _roomList
      for (var doc in roomSnapshot.docs) {
        _roomList.add(doc.data() as Map<String, dynamic>);
      }

      log('Rooms fetched for hotel: $hotelId');
      notifyListeners();
    } catch (e) {
      log('Error fetching rooms: $e');
      throw Exception('Failed to fetch rooms. Error: $e');
    }
  }

  //Drop down box items

  String? _roomsselectedItem;

  final List<String> roomsItems = [
    'Single Room',
    'Double Room',
    'Suite',
    'Deluxe',
    'Executive'
  ];

  String? get roomsSelectedItem => _roomsselectedItem;

  void setRoomSelectedItem(String? value) {
    _roomsselectedItem = value;
    notifyListeners();
  }

  /// Updates an existing room's data in Firestore.
  Future<void> updateRoom(
      String roomId, Map<String, dynamic> updatedData) async {
    try {
      // Fetch the userId of the current user (this will be the document ID in the 'hotels' collection)
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Check if the hotel document exists for this user
      DocumentSnapshot hotelDoc =
          await _firestore.collection('approved_hotels').doc(userId).get();
      if (!hotelDoc.exists) {
        log('Hotel document does not exist for userId: $userId');
        throw Exception(
            'Hotel document does not exist. Please submit the hotel first.');
      }

      // Perform the update on the specified room
      await _firestore
          .collection('approved_hotels')
          .doc(userId)
          .collection('rooms')
          .doc(roomId)
          .update(updatedData);
      // log('Room updated with ID: $roomId');
      notifyListeners();
    } catch (e) {
      log('Error updating room: $e');
      throw Exception('Failed to update room. Error: $e');
    }
  }

  /// Deletes a room from Firestore.
  Future<void> deleteRoom(String roomId) async {
    try {
      // Fetch the userId of the current user (this will be the document ID in the 'hotels' collection)
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Check if the hotel document exists for this user
      DocumentSnapshot hotelDoc =
          await _firestore.collection('approved_hotels').doc(userId).get();
      if (!hotelDoc.exists) {
        log('Hotel document does not exist for userId: $userId');
        throw Exception(
            'Hotel document does not exist. Please submit the hotel first.');
      }
      await _firestore
          .collection('approved_hotels')
          .doc(userId)
          .collection('rooms')
          .doc(roomId)
          .delete();
      // Perform the delete operation on the specified room
      log('Room deleted with ID: $roomId');
      notifyListeners();
    } catch (e) {
      log('Error deleting room: $e');
      throw Exception('Failed to delete room. Error: $e');
    }
  }
}

  // Future<void> getRooms() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? hotelId = prefs.getString('hotelId');

  //   log('hotel id in getrooms   $hotelId!');
  //   if (hotelId == null) {
  //     log('Hotel ID is null,  please submit the hotel first.');
  //     throw Exception('Hotel ID is null. Please submit the hotel first.');
  //   }
  //   try {
  //     // Fetch rooms from Firestore where the hotelId matches
  //     QuerySnapshot roomSnapshot = await _firestore
  //         .collection('hotels')
  //         .doc(hotelId)
  //         .collection('rooms')
  //         .get();

  //     // Clear any previous room data
  //     _roomList.clear();

  //     // Add the rooms to the _roomList
  //     for (var doc in roomSnapshot.docs) {
  //       _roomList.add(doc.data() as Map<String, dynamic>);
  //     }

  //     log('Rooms fetched for hotel: $hotelId');
  //     notifyListeners();
  //   } catch (e) {
  //     log('Error fetching rooms: $e');
  //     throw Exception('Failed to fetch rooms. Error: $e');
  //   }
  // }
  
  //rroms from approved
  // Future<void> getApprovedRooms() async {
  //   try {
  //     // Fetch the userId of the current user (this will be the document ID in the 'hotels' collection)
  //     String userId = FirebaseAuth.instance.currentUser!.uid;

  //     // Retrieve the document for this user (hotel)
  //     DocumentSnapshot hotelDoc =
  //         await _firestore.collection('approved_hotels').doc(userId).get();

  //     // Check if the document exists and has data
  //     if (!hotelDoc.exists) {
  //       log('Hotel document does not exist for userId: $userId');
  //       throw Exception(
  //           'Hotel document does not exist. Please submit the hotel first.');
  //     }

  //     // Extract the hotelId from the document's data (assuming hotelId is a field in the document)
  //     String? hotelId =
  //         userId; // Adjust the key based on your Firestore document structure

  //     log('Hotel ID fetched: $hotelId');

  //     // Fetch rooms from Firestore where the hotelId matches
  //     QuerySnapshot roomSnapshot = await _firestore
  //         .collection('approved_hotels')
  //         .doc(hotelId)
  //         .collection('rooms')
  //         .get();

  //     // Clear any previous room data
  //     _roomList.clear();

  //     // Add the rooms to the _roomList
  //     for (var doc in roomSnapshot.docs) {
  //       _roomList.add(doc.data() as Map<String, dynamic>);
  //     }

  //     log('Rooms fetched for hotel: $hotelId');
  //     notifyListeners();
  //   } catch (e) {
  //     log('Error fetching rooms: $e');
  //     throw Exception('Failed to fetch rooms. Error: $e');
  //   }
  // }