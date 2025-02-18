import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LocationProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? userId = FirebaseAuth.instance.currentUser?.uid;

  String _currentAddress = '';
  LatLng? _currentLocation;
  bool _isLoading = false;
  String _error = '';

  String get currentAddress => _currentAddress;
  LatLng? get currentLocation => _currentLocation;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _error = 'Location services are disabled. Please enable the services';
      notifyListeners();
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _error = 'Location permissions are denied';
        notifyListeners();
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _error = 'Location permissions are permanently denied';
      notifyListeners();
      return false;
    }

    return true;
  }

  Future<void> getCurrentLocation() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      final hasPermission = await handleLocationPermission();
      if (!hasPermission) return;

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _currentLocation = LatLng(position.latitude, position.longitude);

      await _storeLocationInFirebase(position);

      await getAddressFromLatLng(_currentLocation!);
    } catch (e) {
      _error = 'Error getting location: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _storeLocationInFirebase(Position position) async {
    try {
      await _firestore.collection('approved_hotels').doc(userId).update({
        'location': GeoPoint(position.latitude, position.longitude),
      });
    } catch (e) {
      // If document doesn't exist, create it
      if (e is FirebaseException && e.code == 'not-found') {
        await _firestore.collection('approved_hotels').doc(userId).set({
          'location': GeoPoint(position.latitude, position.longitude),
        }, SetOptions(merge: true));
      } else {
        throw Exception('Failed to store location: ${e.toString()}');
      }
    }
  }

  Future<void> getAddressFromLatLng(LatLng position) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks[0];
        _currentAddress =
            '${place.street},${place.subLocality},${place.locality},${place.postalCode}';
      }
    } catch (e) {
      _error = 'Error getting address: ${e.toString()}';
    }
    notifyListeners();
  }

  void clearError() {
    _error = '';
    notifyListeners();
  }
}
