import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/reviewcontroller/review_provider.dart';
import 'package:hotel_side/views/bookings/bookings_list_page/booking_header.dart';
import 'package:hotel_side/views/rooms_list/widgets/states.dart';
import 'package:provider/provider.dart';

class ReviewListPage extends StatelessWidget {
  const ReviewListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<ReviewProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'My Reviews',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[300],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: FutureBuilder(
        future: bookingProvider.getReviewsDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingState();
          } else if (snapshot.hasError) {
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
                    '${snapshot.error}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return Consumer<ReviewProvider>(
            builder: (context, provider, child) {
              final reviews = provider.reviewsList;
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  provider.setSelectedreview(index);
                  final review = reviews[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const ReviewDetailPage(),
                        //   ),
                        // );
                      },
                      // child: ReviewDetailPage(review: review),
                      child: Column(
                        children: [
                          // BookingContainer(booking: booking),
                          const Divider(height: 1),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Check-in',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          // Text(
                                          //   startdate,
                                          //   style: const TextStyle(
                                          //     fontWeight: FontWeight.w600,
                                          //     fontSize: 14,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      width: 1,
                                      color: Colors.grey[300],
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Check-out',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          // Text(
                                          //   enddate,
                                          //   style: const TextStyle(
                                          //     fontWeight: FontWeight.w600,
                                          //     fontSize: 14,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: BookingInfoItem(
                                              icon: Icons.person_outline,
                                              label: 'Childs',
                                              value: review.rating!,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          Expanded(
                                            child: BookingInfoItem(
                                              icon: Icons.cake_outlined,
                                              label: 'Age',
                                              value: review.rating!,
                                              color: Colors.orange,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: BookingInfoItem(
                                              icon: Icons.people_outline,
                                              label: 'Adults',
                                              value: review.rating!,
                                              color: Colors.purple,
                                            ),
                                          ),
                                          Expanded(
                                            child: BookingInfoItem(
                                              icon: Icons.hotel_outlined,
                                              label: 'Customer ID',
                                              value: review.rating!,
                                              color: Colors.teal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
