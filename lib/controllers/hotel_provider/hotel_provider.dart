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
//temporary update
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
      final String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        throw Exception('No authenticated user found');
      }

      final DocumentReference docRef =
          _firestore.collection('approved_hotels').doc(userId);

      final String hotelId = userId;

      Map<String, dynamic> finalHotelData = {
        ...hotelData,
        'userId': hotelId,
        'hotelId': hotelId,
        'created_at': FieldValue.serverTimestamp(),
        'status': 'pending',
      };

      if (_imageUrls.isNotEmpty) {
        finalHotelData['images'] = _imageUrls;
      }

      await docRef.set(finalHotelData);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('hotelId', hotelId);

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

//update hotel
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

  //  delete hotel
  Future<bool> deleteHotel() async {
    try {
      if (hotelId == null) {
        log('No hotel ID available for deletion');
        return false;
      }

      await _firestore.collection('approved_hotels').doc(hotelId).delete();

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
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

      if (userId.isEmpty) {
        debugPrint('User is not logged in');
        return null;
      }

      QuerySnapshot hotelQuery = await _firestore
          .collection('approved_hotels')
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: 'approved')
          .limit(1)
          .get();

      if (hotelQuery.docs.isNotEmpty) {
        String hotelId = hotelQuery.docs.first.id;
        debugPrint('Hotel is approved with ID: $hotelId');
        return hotelId;
      } else {
        debugPrint('No approved hotel found for the user');
        return null;
      }
    } catch (e) {
      debugPrint('Error checking hotel permission: $e');
      return null;
    }
  }
}
