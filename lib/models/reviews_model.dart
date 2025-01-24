class ReviewsModel {
  final String? reviewId;
  final String? hotelId;
  final String? reviewcontent;
  final String? rating;
  final DateTime? reviewdate;
  final String? useremail;
  ReviewsModel({
    this.reviewId,
    this.hotelId,
    this.reviewdate,
    this.reviewcontent,
    this.rating,
    this.useremail,
  });
  factory ReviewsModel.fromMap(
    Map<String, dynamic> map,
  ) {
    final rev = map['reviewDetails'];
    return ReviewsModel(
      reviewId: map['reviewId'] ?? '',
      hotelId: map['hotelId'] ?? '',
      reviewdate: rev[DateTime.now()] ?? DateTime.timestamp(),
      rating: rev['rating'] ?? '',
      reviewcontent: rev['review_content'],
      useremail: map['userEmail'] ?? '',
    );
  }
}
