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
  final List<Map<String, dynamic>> _roomList = [];
  bool _isUploading = false;
  bool get isUploading => _isUploading;
  String? hotelId;

  List<File> get roomImages => _roomImages;
  List<String> get roomImageUrls => _roomImageUrls;
  List<Map<String, dynamic>> get roomList => _roomList;
  bool get isRoomUploading => _isUploading;

  void updateRoomData(String field, dynamic value) {
    roomData[field] = value;
    notifyListeners();
    log('Room data updated: $field = $value');
  }

  Future<void> pickRoomImages() async {
    final pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles.isNotEmpty) {
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
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      DocumentSnapshot hotelDoc =
          await _firestore.collection('approved_hotels').doc(userId).get();

      if (!hotelDoc.exists) {
        log('Hotel document does not exist for userId: $userId');
        throw Exception(
            'Hotel document does not exist. Please submit the hotel first.');
      }

      String? hotelId = userId;

      if (_roomImageUrls.isNotEmpty) {
        roomData['room_images'] = _roomImageUrls;
      }

      DocumentReference roomRef = await _firestore
          .collection('approved_hotels')
          .doc(hotelId)
          .collection('rooms')
          .add(roomData);

      String roomId = roomRef.id;

      Map<String, dynamic> finalRoomData = {
        ...roomData,
        'roomId': roomId,
        'created_at': FieldValue.serverTimestamp(),
        'status': 'nonbooked'
      };

      await roomRef.set(finalRoomData);

      // await roomRef.update({'room_id': roomId});

      log('Room added to hotel with ID: $hotelId, Room ID: $roomId');

      log('Room added to hotel with ID: $hotelId');
      clearRoomImages();
      roomData.clear();
    } catch (e) {
      debugPrint('Error adding room: $e');
    }
  }

  Future<void> getRooms() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      DocumentSnapshot hotelDoc =
          await _firestore.collection('approved_hotels').doc(userId).get();

      if (!hotelDoc.exists) {
        log('Hotel document does not exist for userId: $userId');
        throw Exception(
            'Hotel document does not exist. Please submit the hotel first.');
      }

      String? hotelId = userId;

      log('Hotel ID fetched: $hotelId');

      QuerySnapshot roomSnapshot = await _firestore
          .collection('approved_hotels')
          .doc(hotelId)
          .collection('rooms')
          .get();

      _roomList.clear();
      // clearSelectedRoom();

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

  Future<void> updateRoom(
      String roomId, Map<String, dynamic> updatedData) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

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
          .update(updatedData);
      // log('Room updated with ID: $roomId');
      await getRooms();
      notifyListeners();
    } catch (e) {
      log('Error updating room: $e');
      throw Exception('Failed to update room. Error: $e');
    }
  }

  ///////////////////////////////////////////////////////////
  ///
  Future<void> getRoomById(String roomId) async {
    try {
      // Get the current user's ID
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Fetch the hotel document for the current user
      DocumentSnapshot hotelDoc =
          await _firestore.collection('approved_hotels').doc(userId).get();

      if (!hotelDoc.exists) {
        log('Hotel document does not exist for userId: $userId');
        throw Exception(
            'Hotel document does not exist. Please submit the hotel first.');
      }

      // Fetch the specific room document by roomId
      DocumentSnapshot roomDoc = await _firestore
          .collection('approved_hotels')
          .doc(userId)
          .collection('rooms')
          .doc(roomId)
          .get();

      if (!roomDoc.exists) {
        log('Room document does not exist for roomId: $roomId');
        throw Exception('Room not found. Please check the room ID.');
      }

      // Update the selected room data
      Map<String, dynamic> roomDetails = roomDoc.data() as Map<String, dynamic>;
      log('Room details fetched: $roomDetails');
      _selectedRoom = roomDetails;

      notifyListeners();
    } catch (e) {
      log('Error fetching room details: $e');
      throw Exception('Failed to fetch room details. Error: $e');
    }
  }
////////////////////////////////////////

  Future<void> deleteRoom(String roomId) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

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
      _roomList.removeWhere((room) => room['room_id'] == roomId);

      if (_selectedRoom?['room_id'] == roomId) {
        clearSelectedRoom();
      }

      await getRooms();

      notifyListeners();
    } catch (e) {
      log('Error deleting room: $e');
      throw Exception('Failed to delete room. Error: $e');
    }
  }

  int? _selectedRoomIndex;
  Map<String, dynamic>? _selectedRoom;

  int? get selectedRoomIndex => _selectedRoomIndex;
  Map<String, dynamic>? get selectedRoom => _selectedRoom;

  void setSelectedRoom(int index) {
    if (index >= 0 && index < _roomList.length) {
      _selectedRoomIndex = index;
      _selectedRoom = _roomList[index];
      // notifyListeners();
    }
  }

  void clearSelectedRoom() {
    _selectedRoomIndex = null;
    _selectedRoom = null;
    notifyListeners();
  }

  ///////////////////////////////////////////
  // int? _selectedBookingRoomIndex;
  // RoomModel? _selectedBookingRoom;

  // int? get selectedBookingRoomIndex => _selectedBookingRoomIndex;
  // RoomModel? get selectedBookingRoom => _selectedBookingRoom;

  // void setSelectedBookingRoom(int index) {
  //   if (index >= 0 && index < _roomList.length) {
  //     _selectedBookingRoomIndex = index;
  //     _selectedRoom = _roomList[index];
  //     // notifyListeners();
  //   }
  // }
}
