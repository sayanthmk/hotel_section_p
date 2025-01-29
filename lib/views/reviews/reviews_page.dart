import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/reviewcontroller/review_provider.dart';
import 'package:hotel_side/utils/appbar/cutomappbar.dart';
import 'package:hotel_side/views/reviews/widgets/review_chip.dart';
import 'package:hotel_side/views/reviews/widgets/reviewcard.dart';
import 'package:hotel_side/views/rooms_list/widgets/states.dart';
import 'package:provider/provider.dart';

class ReviewListPage extends StatelessWidget {
  const ReviewListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const HotelSideCustomAppbar(
        heading: 'Reviews',
      ),
      body: FutureBuilder(
        future: reviewProvider.getReviewsDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingState();
          } else if (snapshot.hasError) {
            return ErrorStateWidget(error: snapshot.error);
          }

          return Consumer<ReviewProvider>(
            builder: (context, provider, child) {
              final reviews = provider.reviewsList;
              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  provider.setSelectedreview(index);
                  final review = reviews[index];
                  return ReviewCardAnimation(
                    index: index,
                    child: EnhancedReviewCard(review: review),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class ErrorStateWidget extends StatelessWidget {
  final Object? error;

  const ErrorStateWidget({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
          const SizedBox(height: 16),
          Text(
            'Error loading reviews',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$error',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // Implement refresh functionality
              Provider.of<ReviewProvider>(context, listen: false)
                  .getReviewsDetails();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
