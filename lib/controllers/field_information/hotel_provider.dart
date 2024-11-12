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
    'userId': '', // Store the user ID who created the hotel
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
    'created_at': null, // Add timestamp for when hotel is created
  };

  final List<File> _images = [];
  final List<String> _imageUrls = [];
  bool _isUploading = false;

  List<File> get images => _images;
  List<String> get imageUrls => _imageUrls;
  bool get isUploading => _isUploading;
  String? hotelId;

  // Update hotel data based on the form inputs
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

  // Image handling methods remain the same
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

  // Dropdown items remain the same
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
      // String userId = FirebaseAuth.instance.currentUser!.uid;

      // Create a new document reference with auto-generated ID
      DocumentReference docRef = _firestore.collection('hotels').doc();
      hotelId = docRef.id; // Use the auto-generated ID as hotel ID

      if (_imageUrls.isNotEmpty) {
        hotelData['images'] = _imageUrls;
      }

      // Add user ID and creation timestamp to hotel data
      // hotelData['userId'] = hotelId;
      // hotelData['created_at'] = FieldValue.serverTimestamp();

      // Save to Firestore using the auto-generated ID
      await docRef.set(hotelData);

      // Save hotel ID to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('hotelId', hotelId!);

      log('Hotel submitted successfully with ID: $hotelId');
      clearImages();
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
          .collection('hotels')
          .where('userId', isEqualTo: userId)
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

  String? getUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  Future<Map<String, dynamic>?> getCurrentHotelDetails() async {
    try {
      if (hotelId == null) {
        // Try to get hotel ID from registration check
        hotelId = await checkHotelRegistration();
        if (hotelId == null) {
          log('No hotel ID found');
          return null;
        }
      }

      // Get hotel document using hotel ID
      DocumentSnapshot hotelDoc =
          await _firestore.collection('hotels').doc(hotelId).get();

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

      await _firestore.collection('hotels').doc(hotelId).update(hotelData);
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

      await _firestore.collection('hotels').doc(hotelId).delete();

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
}
