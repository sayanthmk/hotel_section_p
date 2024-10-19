import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hotel_side/models/hotel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BackupHotelProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final Map<String, dynamic> hotelData = {
    // Remove 'id' field as Firebase will generate it
    'hotel_type': '',
    'property_setup': '',
    'hotel_name': '',
    'Booking_since': '',
    'contact_number': '',
    'email_address': '',
    'city': '',
    'state': '',
    'country': '',
    'entire_property': false,
    'private_property': false,
    'pincode': null,
    'free_cancel': false,
    'couple_friendly': false,
    'parking_facility': false,
    'restaurant_facility': false,
    'pan_number': '',
    'property_number': '',
    'gst_number': '',
    'leased': false,
    'registration': false,
    'document_image': false,
    'images': [],
  };

  final List<File> _images = [];
  final List<String> _imageUrls = [];
  bool _isUploading = false;

  List<File> get images => _images;
  List<String> get imageUrls => _imageUrls;
  bool get isUploading => _isUploading;
  String? hotelId; // Store the hotel document ID here after creation

  // Room data structure
  final Map<String, dynamic> roomData = {
    "room_area": '',
    "accomadation_type": '',
    "Property Size": 0,
    "Select Extra Bed Types": 0,
    "Cupboard": false,
    "Wardrobe": false,
    "Accommodation Only": false,
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

    // 'room_type': '',
    // 'room_size': null,
    // 'base_price': null,
    // 'max_occupants': null,
    // 'wifi_available': false,
    // 'breakfast_included': false,
    'room_images': [],
  };

  final List<File> _roomImages = [];
  final List<String> _roomImageUrls = [];
  bool _isRoomUploading = false;

  List<File> get roomImages => _roomImages;
  List<String> get roomImageUrls => _roomImageUrls;
  bool get isRoomUploading => _isRoomUploading;
//hotel functions==========================================
  // Update hotel data based on the form inputs
  void updateHotelData(String field, dynamic value) {
    hotelData[field] = value;
    notifyListeners();
    print('-------------------data is updated--------------------');
    log('data is updated');
  }

//
  // Function to get hotelId from SharedPreferences
  Future<void> loadHotelIdFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    hotelId = prefs.getString('hotelId');
    log('data:loadHotelIdFromPrefs-----$hotelId!');
    notifyListeners();
  }

  Future<void> pickImages() async {
    final pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      _images.addAll(pickedFiles.map((file) => File(file.path)));
      notifyListeners();
    }
  }

  Future<void> captureImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _images.add(File(pickedFile.path));
      notifyListeners();
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < _images.length) {
      _images.removeAt(index);
      notifyListeners();
    }
  }

  Future<bool> uploadImages() async {
    if (_images.isEmpty) return false;
    log('image fun');
    _isUploading = true;
    notifyListeners();

    try {
      for (var image in _images) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('images/${DateTime.now().toString()}');
        final uploadTask = ref.putFile(image);
        final snapshot = await uploadTask.whenComplete(() {});
        final url = await snapshot.ref.getDownloadURL();
        _imageUrls.add(url);
      }
      _isUploading = false;
      _images.clear();
      notifyListeners();
      return true;
    } catch (e) {
      print('Error uploading images: $e');
      _isUploading = false;
      notifyListeners();
      return false;
    }
  }

  void clearImages() {
    _images.clear();
    _imageUrls.clear();
    notifyListeners();
  }

  //================
  String? _selectedItem;

  final List<String> items = ['Hotel', 'Resort', 'Bunglow', 'Dorm'];

  String? get selectedItem => _selectedItem;

  void setSelectedItem(String? value) {
    _selectedItem = value;
    notifyListeners();
  }

  ///=====================================================
  Future submitHotel() async {
    try {
      // Add the uploaded image URLs to the hotel data
      if (_imageUrls.isNotEmpty) {
        hotelData['images'] = _imageUrls;
      }

      // Retrieve the authenticated user's UID from FirebaseAuth
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Add the user ID to the hotel data
      hotelData['userId'] = userId;

      // Set the hotelId to be the same as the authenticated user's UID
      hotelId = userId;

      // Use the userId as the document ID for the "hotels" collection
      Hotel hotel = Hotel(hotelData);
      await _firestore
          .collection('hotels')
          .doc(userId) // Use userId as the document ID
          .set(hotel.toJson()); // Add the hotel data using set() method

      // Store the hotelId in Shared Preferences for later use
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('hotelId', hotelId!);

      log('Hotel submitted with unique ID: $hotelId');
      clearImages(); // Clear image data after submission
    } catch (e) {
      debugPrint('Error adding hotel: $e');
    }
    return hotelId;
  }

  // ================== Room Data Methods ==================

  // Similar to updateHotelData, this method updates roomData dynamically
  void updateRoomData(String field, dynamic value) {
    roomData[field] = value;
    notifyListeners();
    log('Room data updated: $field = $value');
  }

  Future<void> submitRoom() async {
    try {
      if (hotelId == null) {
        throw Exception('Hotel ID not available. Submit hotel first.');
      }

      if (_roomImageUrls.isNotEmpty) {
        roomData['room_images'] = _roomImageUrls;
      }

      await _firestore
          .collection('hotels')
          .doc(hotelId)
          .collection('rooms')
          .add(roomData);

      log('Room added to hotel with ID: $hotelId');
      clearRoomImages();
    } catch (e) {
      debugPrint('Error adding room: $e');
    }
  }

  // ================== Image Handling for Room ==================

  Future<void> pickRoomImages() async {
    final pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      _roomImages.addAll(pickedFiles.map((file) => File(file.path)));
      notifyListeners();
    }
  }

  // Function to pick room images from the camera
  Future<void> captureRoomImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _roomImages.add(File(pickedFile.path));
      notifyListeners();
    }
  }

  Future<bool> uploadRoomImages() async {
    if (_roomImages.isEmpty) return false;

    _isRoomUploading = true;
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
      _isRoomUploading = false;
      _roomImages.clear();
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error uploading room images: $e');
      _isRoomUploading = false;
      notifyListeners();
      return false;
    }
  }

  void removeRoomImage(int index) {
    if (index >= 0 && index < _roomImages.length) {
      _roomImages.removeAt(index);
      notifyListeners();
    }
  }

  void clearRoomImages() {
    _roomImages.clear();
    _roomImageUrls.clear();
    notifyListeners();
  }

  //----------------- Function to fetch rooms -----------------
  List<Map<String, dynamic>> _roomList = [];

  List<Map<String, dynamic>> get roomList => _roomList;
  Future<void> getRooms() async {
    if (hotelId == null) {
      log('hotel id:$hotelId');
      throw Exception('Hotel ID is null. Please submit the hotel first.');
    }
    try {
      QuerySnapshot roomSnapshot = await _firestore
          .collection('hotels')
          .doc(hotelId)
          .collection('rooms')
          .get();

      _roomList = roomSnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching rooms: $e');
    }
  }

  //======================[[[[[[=[=[=[[=============]]]]]]]]]]
  Future<String?> checkHotelRegistration() async {
    try {
      // Retrieve the authenticated user's UID from FirebaseAuth
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Fetch the document corresponding to the userId from the 'hotels' collection
      DocumentSnapshot hotelDoc =
          await _firestore.collection('hotels').doc(userId).get();

      // Check if the document exists
      if (hotelDoc.exists) {
        log('Hotel is already registered with ID: $userId');

        // Hotel exists, return the userId as the hotelId
        return userId;
      } else {
        log('Hotel is not registered.');

        // Hotel not registered, return null
        return null;
      }
    } catch (e) {
      debugPrint('Error checking hotel registration: $e');
      return null;
    }
  }
}
// // hotel submission function
//   // Future<void> submitHotel() async {
//   //   try {
//   //     if (_imageUrls.isNotEmpty) {
//   //       hotelData['images'] = _imageUrls;
//   //     }

//   //     // Save hotel data with the current user's UID as the document ID
//   //     String userId = FirebaseAuth.instance.currentUser!.uid;

//   //     Hotel hotel = Hotel(hotelData);
//   //     await _firestore.collection('hotels').doc(userId).set(hotel.toJson());

//   //     hotelId = userId; // Use UID as hotelId

//   //     // Store the hotelId in Shared Preferences
//   //     SharedPreferences prefs = await SharedPreferences.getInstance();
//   //     await prefs.setString('hotelId', hotelId!);

//   //     log('Hotel submitted with ID: $hotelId');
//   //     clearImages();
//   //   } catch (e) {
//   //     debugPrint('Error adding hotel: $e');
//   //   }
//   // }
//   Future<void> submitHotel() async {
//   try {
//     // Add the uploaded image URLs to the hotel data
//     if (_imageUrls.isNotEmpty) {
//       hotelData['images'] = _imageUrls;
//     }

//     // Retrieve the authenticated user's UID from FirebaseAuth
//     String userId = FirebaseAuth.instance.currentUser!.uid;

//     // Add the hotel data to the "hotels" collection, under a new unique document ID
//     Hotel hotel = Hotel(hotelData);
//     DocumentReference hotelRef = await _firestore
//         .collection('users') // Create a "users" collection to organize hotels by user ID
//         .doc(userId) // Use the user's UID as the document ID for the user
//         .collection('hotels') // Within each user, store multiple hotels
//         .add(hotel.toJson()); // Firestore will generate a unique hotel document ID

//     // Save the generated hotel document ID for future reference (e.g., adding rooms)
//     hotelId = hotelRef.id;

//     // Store the hotelId in Shared Preferences for later use
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('hotelId', hotelId!);

//     log('Hotel submitted with unique ID: $hotelId');
//     clearImages(); // Clear image data after submission
//   } catch (e) {
//     debugPrint('Error adding hotel: $e');
//   }
// }

// //   Future<void> submitHotel() async {
// //     try {
// //       if (_imageUrls.isNotEmpty) {
// //         hotelData['images'] = _imageUrls;
// //       }
// // //-----------------------------

// //       // // Add the hotel data to the "hotels" collection
// //       // Hotel hotel = Hotel(hotelData);
// //       // DocumentReference hotelRef =
// //       //     //await _firestore.collection('hotels').add(hotel.toJson());
// //       //       await _firestore.collection('hotels').doc(FirebaseAuth.instance.currentUser!.uid).set(hotel.toJson());

// // // Add the hotel data to the "hotels" collection
// //       Hotel hotel = Hotel(hotelData);
// //       await _firestore
// //           .collection('hotels')
// //           .doc(FirebaseAuth.instance.currentUser!.uid)
// //           .set(hotel.toJson());
// //       DocumentReference hotelRef = _firestore
// //           .collection('hotels')
// //           .doc(FirebaseAuth.instance.currentUser!.uid);

// //       // Save the generated hotel ID for future use (like adding rooms)
// //       hotelId = hotelRef.id;

// //       SharedPreferences prefs = await SharedPreferences.getInstance();
// //       await prefs.setString('hotelId', hotelId!);

// //       print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&$hotelId');
// // //-----------------------------------

// //       // Hotel hotel = Hotel(hotelData);
// //       // await _firestore.collection('hotels').add(hotel.toJson());

// //       log('hotel submitted');
// //       clearImages();
// //     } catch (e) {
// //       debugPrint('Error adding hotel: $e');
// //     }
// //   }

  // Future<void> submitHotel() async {
  //   try {
  //     // Add the uploaded image URLs to the hotel data
  //     if (_imageUrls.isNotEmpty) {
  //       hotelData['images'] = _imageUrls;
  //     }

  //     // Retrieve the authenticated user's UID from FirebaseAuth
  //     String userId = FirebaseAuth.instance.currentUser!.uid;

  //     // Add the user ID to the hotel data
  //     hotelData['userId'] = userId;

  //     // Add the hotel data directly to the "hotels" collection
  //     Hotel hotel = Hotel(hotelData);
  //     DocumentReference hotelRef = await _firestore.collection('hotels').add(
  //         hotel.toJson()); // Firestore will generate a unique hotel document ID

  //     // Save the generated hotel document ID for future reference (e.g., adding rooms)
  //     hotelId = hotelRef.id;

  //     // Store the hotelId in Shared Preferences for later use
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setString('hotelId', hotelId!);

  //     log('Hotel submitted with unique ID: $hotelId');
  //     clearImages(); // Clear image data after submission
  //   } catch (e) {
  //     debugPrint('Error adding hotel: $e');
  //   }
  // }
//-----------------------------------

  // Future<void> addRoomToHotel(Map<String, dynamic> roomData) async {
  //   if (hotelId == null) {
  //     throw Exception('Hotel ID not available. Submit hotel first.');
  //   }

  //   try {
  //     await _firestore
  //         .collection('hotels')
  //         .doc(hotelId)
  //         .collection('rooms')
  //         .add(roomData);
  //     log('Room added to hotel with ID: $hotelId');
  //     notifyListeners();
  //   } catch (e) {
  //     throw Exception("Failed to add room: $e");
  //   }
  // }

  // bool _isLoading = true;
  // bool _isHotelRegistered = false;
  // String? _errorMessage;

  // bool get isLoading => _isLoading;
  // bool get isHotelRegistered => _isHotelRegistered;
  // String? get errorMessage => _errorMessage;

  // Future<void> checkIfHotelRegistered() async {
  //   try {
  //     _isLoading = true;
  //     notifyListeners();

  //     final user = FirebaseAuth.instance.currentUser;
  //     if (user == null) {
  //       _errorMessage = 'User not logged in';
  //       _isLoading = false;
  //       notifyListeners();
  //       return;
  //     }

  //     // Check Firestore for hotel data linked to this user
  //     DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //         .collection('hotels')
  //         .doc(user.uid)
  //         .get();

  //     if (snapshot.exists) {
  //       _isHotelRegistered = true;
  //     } else {
  //       _isHotelRegistered = false;
  //     }
  //   } catch (e) {
  //     _errorMessage = 'Error checking hotel registration: $e';
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }