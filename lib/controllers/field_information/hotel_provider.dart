import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HotelProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final Map<String, dynamic> hotelData = {
    'userId': '',
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
    'created_at': null,
  };

  final List<File> _images = [];
  final List<String> _imageUrls = [];
  bool _isUploading = false;

  List<File> get images => _images;
  List<String> get imageUrls => _imageUrls;
  bool get isUploading => _isUploading;
  String? hotelId;

  void updateHotelData(String field, dynamic value) {
    hotelData[field] = value;
    notifyListeners();
    log('Hotel data updated: $field = $value');
  }

  Future<void> loadHotelIdFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    hotelId = prefs.getString('hotelId');
    log('Loaded hotelId from prefs: $hotelId');
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
    log('Starting hotel image upload');
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

  String? _selectedItem;
  final List<String> items = ['Hotel', 'Resort', 'Bunglow', 'Dorm'];
  String? get selectedItem => _selectedItem;

  void setSelectedItem(String? value) {
    _selectedItem = value;
    notifyListeners();
  }

  Future<String?> submitHotel() async {
    try {
      // Get the current user's ID
      final String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        throw Exception('No authenticated user found');
      }
      // Create a new document reference with auto-generated ID
      final DocumentReference docRef =
          _firestore.collection('approved_hotels').doc(userId);
      // final String hotelId = docRef.id;
      final String hotelId = userId;

      // Prepare hotel data
      Map<String, dynamic> finalHotelData = {
        ...hotelData, // Assuming hotelData is defined elsewhere
        'userId': hotelId,
        'hotelId': hotelId,
        'created_at': FieldValue.serverTimestamp(),
        'status': 'pending',
      };

      // Add images if available
      if (_imageUrls.isNotEmpty) {
        finalHotelData['images'] = _imageUrls;
      }

      await docRef.set(finalHotelData);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('hotelId', hotelId);

      log('Hotel submitted successfully with ID: $hotelId');
      clearImages(); // Assuming this function is defined elsewhere

      return hotelId;
    } catch (e) {
      debugPrint('Error submitting hotel: $e');
      return null;
    }
  }

  Future<String?> checkHotelRegistration() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Query hotels collection for documents where userId matches
      QuerySnapshot hotelQuery = await _firestore
          .collection('approved_hotels')
          .where('userId', isEqualTo: userId)
          // .where('status', isEqualTo: 'approved')
          .limit(1)
          .get();

      if (hotelQuery.docs.isNotEmpty) {
        hotelId = hotelQuery.docs.first.id;
        log('Hotel already registered with ID: $hotelId');
        return hotelId;
      } else {
        log('Hotel not registered');
        return null;
      }
    } catch (e) {
      debugPrint('Error checking hotel registration: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getCurrentHotelDetails() async {
    try {
      if (hotelId == null) {
        hotelId = await checkHotelRegistration();
        if (hotelId == null) {
          log('No hotel ID found');
          return null;
        }
      }

      DocumentSnapshot hotelDoc =
          await _firestore.collection('approved_hotels').doc(hotelId).get();

      if (hotelDoc.exists) {
        Map<String, dynamic> hotelDetails =
            hotelDoc.data() as Map<String, dynamic>;
        log('Fetched current hotel details for hotelId: $hotelId');
        return hotelDetails;
      } else {
        log('No hotel found for hotelId: $hotelId');
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching current hotel details: $e');
      return null;
    }
  }

  // Method to update existing hotel
  Future<bool> updateHotel() async {
    try {
      if (hotelId == null) {
        log('No hotel ID available for update');
        return false;
      }

      if (_imageUrls.isNotEmpty) {
        hotelData['images'] = _imageUrls;
      }

      await _firestore
          .collection('approved_hotels')
          .doc(hotelId)
          .update(hotelData);
      log('Hotel updated successfully: $hotelId');
      return true;
    } catch (e) {
      debugPrint('Error updating hotel: $e');
      return false;
    }
  }

  // Method to delete hotel
  Future<bool> deleteHotel() async {
    try {
      if (hotelId == null) {
        log('No hotel ID available for deletion');
        return false;
      }

      await _firestore.collection('approved_hotels').doc(hotelId).delete();

      // Clear SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('hotelId');

      hotelId = null;
      log('Hotel deleted successfully');
      return true;
    } catch (e) {
      debugPrint('Error deleting hotel: $e');
      return false;
    }
  }

  Future<String?> hotelPermission() async {
    try {
      // Get the current user's ID
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

      if (userId.isEmpty) {
        debugPrint('User is not logged in');
        return null;
      }

      // Query the approved_hotels collection for a document matching the userId and status
      QuerySnapshot hotelQuery = await _firestore
          .collection('approved_hotels')
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: 'approved')
          .limit(1)
          .get();

      // Check if any documents are returned
      if (hotelQuery.docs.isNotEmpty) {
        // Get the first hotel's ID
        String hotelId = hotelQuery.docs.first.id;
        debugPrint('Hotel is approved with ID: $hotelId');
        return hotelId;
      } else {
        debugPrint('No approved hotel found for the user');
        return null;
      }
    } catch (e) {
      // Log the error for debugging purposes
      debugPrint('Error checking hotel permission: $e');
      return null;
    }
  }
}
// Future<String?> submitHotel() async {
//   try {
//     // Get the current user's ID
//     // String userId = FirebaseAuth.instance.currentUser!.uid;

//     // Create a new document reference with auto-generated ID
//     DocumentReference docRef = _firestore.collection('hotels').doc();
//     hotelId = docRef.id; // Use the auto-generated ID as hotel ID

//     if (_imageUrls.isNotEmpty) {
//       hotelData['images'] = _imageUrls;
//     }

//     // Add user ID and creation timestamp to hotel data
//     // hotelData['userId'] = hotelId;
//     // hotelData['created_at'] = FieldValue.serverTimestamp();

//     // Save to Firestore using the auto-generated ID
//     await docRef.set(hotelData);

//     // Save hotel ID to SharedPreferences
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('hotelId', hotelId!);

//     log('Hotel submitted successfully with ID: $hotelId');
//     clearImages();
//     return hotelId;
//   } catch (e) {
//     debugPrint('Error submitting hotel: $e');
//     return null;
//   }
// }
// Future<Map<String, dynamic>?> fetchHotelDetailsBasedOnStatus() async {
//   try {
//     if (hotelId == null) {
//       hotelId = await checkApprovedHotelRegistration();
//       if (hotelId == null) {
//         log('No hotel ID found');
//         return null;
//       }
//     }

//     // Check status field in the approved_hotels collection
//     DocumentSnapshot statusDoc =
//         await _firestore.collection('approved_hotels').doc(hotelId).get();

//     if (statusDoc.exists) {
//       Map<String, dynamic> statusData =
//           statusDoc.data() as Map<String, dynamic>;
//       String? status = statusData['status'];

//       if (status == 'approved') {
//         return await getApprovedHotelDetails();
//       } else {
//         return await getCurrentHotelDetails();
//       }
//     } else {
//       log('No status document found for hotelId: $hotelId');
//       return await getCurrentHotelDetails();
//     }
//   } catch (e) {
//     debugPrint('Error checking hotel status: $e');
//     return null;
//   }
// }
// Future<String?> checkApprovedHotelRegistration() async {
//   try {
//     String userId = FirebaseAuth.instance.currentUser!.uid;

//     // Query hotels collection for documents where userId matches
//     QuerySnapshot hotelQuery = await _firestore
//         .collection('approved_hotels')
//         .where('userId', isEqualTo: userId)
//         .limit(1)
//         .get();

//     if (hotelQuery.docs.isNotEmpty) {
//       hotelId = hotelQuery.docs.first.id;
//       log('Hotel already registered with ID: $hotelId');
//       return hotelId;
//     } else {
//       log('Hotel not registered');
//       return null;
//     }
//   } catch (e) {
//     debugPrint('Error checking hotel registration: $e');
//     return null;
//   }
// }

// String? getUserId() {
//   User? user = FirebaseAuth.instance.currentUser;
//   return user?.uid;
// }

// Future<Map<String, dynamic>?> getCurrentHotelDetails() async {
//   try {
//     if (hotelId == null) {
//       // Try to get hotel ID from registration check
//       hotelId = await checkHotelRegistration();
//       if (hotelId == null) {
//         log('No hotel ID found');
//         return null;
//       }
//     }

//     // Get hotel document using hotel ID
//     DocumentSnapshot hotelDoc =
//         await _firestore.collection('hotels').doc(hotelId).get();

//     if (hotelDoc.exists) {
//       Map<String, dynamic> hotelDetails =
//           hotelDoc.data() as Map<String, dynamic>;
//       log('Fetched current hotel details for hotelId: $hotelId');
//       return hotelDetails;
//     } else {
//       log('No hotel found for hotelId: $hotelId');
//       return null;
//     }
//   } catch (e) {
//     debugPrint('Error fetching current hotel details: $e');
//     return null;
//   }
// }

// Future<Map<String, dynamic>?> getApprovedHotelDetails() async {
//   try {
//     if (hotelId == null) {
//       // Try to get hotel ID from registration check
//       hotelId = await checkHotelRegistration();
//       if (hotelId == null) {
//         log('No hotel ID found');
//         return null;
//       }
//     }

//     // Get hotel document using hotel ID
//     DocumentSnapshot hotelDoc =
//         await _firestore.collection('hotels').doc(hotelId).get();

//     if (hotelDoc.exists) {
//       Map<String, dynamic> hotelDetails =
//           hotelDoc.data() as Map<String, dynamic>;
//       log('Fetched current hotel details for hotelId: $hotelId');
//       return hotelDetails;
//     } else {
//       log('No hotel found for hotelId: $hotelId');
//       return null;
//     }
//   } catch (e) {
//     debugPrint('Error fetching current hotel details: $e');
//     return null;
//   }
// }
// Future<Map<String, dynamic>?> getApprovedHotelDetails() async {
//   try {
//     if (hotelId == null) {
//       hotelId = await checkHotelRegistration();
//       if (hotelId == null) {
//         log('No hotel ID found');
//         return null;
//       }
//     }

//     DocumentSnapshot hotelDoc =
//         await _firestore.collection('approved_hotels').doc(hotelId).get();

//     if (hotelDoc.exists) {
//       Map<String, dynamic> hotelDetails =
//           hotelDoc.data() as Map<String, dynamic>;
//       log('Fetched approved hotel details for hotelId: $hotelId');
//       return hotelDetails;
//     } else {
//       log('No hotel found for hotelId: $hotelId');
//       return null;
//     }
//   } catch (e) {
//     debugPrint('Error fetching approved hotel details: $e');
//     return null;
//   }
// }
