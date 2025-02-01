import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hotel_side/models/reviews_model.dart';

class ReviewProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  final List<ReviewsModel> _reviewsList = [];
  List<ReviewsModel> get reviewsList => _reviewsList;

  Future<dynamic> getReviewsDetails() async {
    if (userId == null) {
      throw Exception('No user is logged in.');
    }

    try {
      QuerySnapshot bookingsnapshot = await _firestore
          .collection('approved_hotels')
          .doc(userId)
          .collection('reviews')
          .get();

      _reviewsList.clear();

      for (var doc in bookingsnapshot.docs) {
        log('Document Data: ${doc.data()}');
        _reviewsList
            .add(ReviewsModel.fromMap(doc.data() as Map<String, dynamic>));
        log(_reviewsList.toString());
      }
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch reviews details: $e');
    }
  }

  int? _selectedReviewIndex;
  ReviewsModel? _selectedreview;

  int? get selectedReviewIndex => _selectedReviewIndex;
  ReviewsModel? get selectedReview => _selectedreview;

  void setSelectedreview(int index) {
    if (index >= 0 && index < _reviewsList.length) {
      _selectedReviewIndex = index;
      _selectedreview = _reviewsList[index];
    }
  }

  void clearSelectedReviews() {
    _selectedReviewIndex = null;
    _selectedreview = null;
    notifyListeners();
  }
}
