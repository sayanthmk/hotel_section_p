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
  //Drop down box items

  String? _selectedItem;

  final List<String> items = ['Hotel', 'Resort', 'Bunglow', 'Dorm'];

  String? get selectedItem => _selectedItem;

  void setSelectedItem(String? value) {
    _selectedItem = value;
    notifyListeners();
  }

  Future submitHotel() async {
    try {
      if (_imageUrls.isNotEmpty) {
        hotelData['images'] = _imageUrls;
      }

      String userId = FirebaseAuth.instance.currentUser!.uid;
      // hotelData['userId'] = userId;
      // hotelId = userId;

      await _firestore.collection('hotels').doc(userId).set(hotelData);

      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString('hotelId', hotelId!);

      log('Hotel submitted successfully with ID: $hotelId');
      clearImages();
    } catch (e) {
      debugPrint('Error submitting hotel: $e');
    }
    return hotelId;
  }

  Future<String?> checkHotelRegistration() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot hotelDoc =
          await _firestore.collection('hotels').doc(userId).get();

      if (hotelDoc.exists) {
        log('Hotel already registered: $userId');
        return userId;
      } else {
        log('Hotel not registered');
        return null;
      }
    } catch (e) {
      debugPrint('Error checking hotel registration: $e');
      return null;
    }
  }

  /// Method to get the current user's ID (UID)
  String? getUserId() {
    // Get the current user from FirebaseAuth
    User? user = FirebaseAuth.instance.currentUser;

    // Return the user ID (UID) if the user is logged in, otherwise return null
    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }
}
