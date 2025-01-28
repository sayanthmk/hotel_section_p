import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/reviewcontroller/review_provider.dart';
import 'package:hotel_side/utils/appbar/cutomappbar.dart';
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

class EnhancedReviewCard extends StatelessWidget {
  final dynamic review;

  const EnhancedReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _buildHeader(context),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[400]!, Colors.blue[300]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // RatingDisplay(rating: review.rating!),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            review.rating,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
                // ReviewIdChip(reviewId: review.reviewId!),
              ],
            ),
          ),
          // _buildContent(),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review.reviewcontent!,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          // _buildFooter(context),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person_outline,
                            size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          review.useremail!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.calendar_today,
                            size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          review.reviewdate!.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ReviewIdChip extends StatelessWidget {
  final String reviewId;

  const ReviewIdChip({super.key, required this.reviewId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '#$reviewId',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class ReviewCardAnimation extends StatelessWidget {
  final int index;
  final Widget child;

  const ReviewCardAnimation({
    super.key,
    required this.index,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 400 + (index * 100)),
      curve: Curves.easeOutQuad,
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}


 // Widget _buildHeader(BuildContext context) {
  //   return Container(
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       gradient: LinearGradient(
  //         colors: [Colors.blue[400]!, Colors.blue[300]!],
  //         begin: Alignment.topLeft,
  //         end: Alignment.bottomRight,
  //       ),
  //       borderRadius: const BorderRadius.only(
  //         topLeft: Radius.circular(20),
  //         topRight: Radius.circular(20),
  //       ),
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         RatingDisplay(rating: review.rating!),
  //         // ReviewIdChip(reviewId: review.reviewId!),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildContent() {
  //   return Container(
  //     padding: const EdgeInsets.all(16),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           review.reviewcontent!,
  //           style: const TextStyle(
  //             fontSize: 16,
  //             height: 1.5,
  //             color: Colors.black87,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildFooter(BuildContext context) {
  //   return Container(
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: Colors.grey[50],
  //       borderRadius: const BorderRadius.only(
  //         bottomLeft: Radius.circular(20),
  //         bottomRight: Radius.circular(20),
  //       ),
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Row(
  //               children: [
  //                 Icon(Icons.person_outline, size: 16, color: Colors.grey[600]),
  //                 const SizedBox(width: 4),
  //                 Text(
  //                   review.useremail!,
  //                   style: TextStyle(
  //                     fontSize: 14,
  //                     color: Colors.grey[800],
  //                     fontWeight: FontWeight.w500,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(height: 4),
  //             Row(
  //               children: [
  //                 Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
  //                 const SizedBox(width: 4),
  //                 Text(
  //                   review.reviewdate!.toString(),
  //                   style: TextStyle(
  //                     fontSize: 12,
  //                     color: Colors.grey[600],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //         // IconButton(
  //         //   icon: const Icon(Icons.more_vert),
  //         //   onPressed: () {
  //         //     // Implement more options functionality
  //         //   },
  //         // ),
  //       ],
  //     ),
  //   );
  // }


// class RatingDisplay extends StatelessWidget {
//   final String rating;

//   const RatingDisplay({super.key, required this.rating});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.2),
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Row(
//             children: [
//               const Icon(
//                 Icons.star,
//                 color: Colors.white,
//                 size: 18,
//               ),
//               const SizedBox(width: 4),
//               Text(
//                 rating,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

  // PreferredSizeWidget _buildAppBar() {
  //   return AppBar(
  //     title: const Text(
  //       'My Reviews',
  //       style: TextStyle(
  //         color: Colors.white,
  //         fontSize: 22,
  //         fontWeight: FontWeight.w600,
  //         letterSpacing: 0.5,
  //       ),
  //     ),
  //     centerTitle: true,
  //     backgroundColor: Colors.blue[400],
  //     elevation: 0,
  //     iconTheme: const IconThemeData(color: Colors.white),
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(
  //         bottom: Radius.circular(30),
  //       ),
  //     ),
  //     flexibleSpace: Container(
  //       decoration: BoxDecoration(
  //         gradient: LinearGradient(
  //           colors: [Colors.blue[400]!, Colors.blue[600]!],
  //           begin: Alignment.topCenter,
  //           end: Alignment.bottomCenter,
  //         ),
  //       ),
  //     ),
  //   );
  // }