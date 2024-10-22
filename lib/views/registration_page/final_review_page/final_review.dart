import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/field_information/hotel_provider.dart';
import 'package:hotel_side/views/bottom_nav/bottom_nav.dart';
import 'package:hotel_side/views/registration_page/final_review_page/widgets/detail_card.dart';
import 'package:provider/provider.dart';

class FinalReview extends StatelessWidget {
  const FinalReview({super.key});

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<HotelProvider>(context);
    final hotelData = hotelProvider.hotelData;

    return Scaffold(
      backgroundColor: const Color(0xffF5F9FF),
      appBar: AppBar(
        elevation: 0,
        title: const Text('Final Review'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DetailFinalReviewCard(),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    log('Hotel Type: ${hotelData['hotel_type']}');
                    log('Property Setup: ${hotelData['property_setup']}');
                    log('Contact Number: ${hotelData['info']?['contact_number']}');
                    log('State: ${hotelData['location']?['state']}');

                    hotelProvider.submitHotel().then((_) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BottomNavScreen(),
                      ));
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error: $error'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Submit Hotel Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


  // Widget _buildSectionTitle(String title) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 16),
  //     child: Row(
  //       children: [
  //         Container(
  //           width: 4,
  //           height: 24,
  //           decoration: BoxDecoration(
  //             color: Colors.blue[700],
  //             borderRadius: BorderRadius.circular(2),
  //           ),
  //         ),
  //         const SizedBox(width: 8),
  //         Text(
  //           title,
  //           style: const TextStyle(
  //             fontSize: 20,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildInfoCard(String title, dynamic value) {
  //   return Card(
  //     elevation: 0,
  //     color: Colors.white,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(12),
  //       side: BorderSide(color: Colors.grey.shade200),
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.all(16),
  //       child: Row(
  //         children: [
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   title,
  //                   style: TextStyle(
  //                     color: Colors.grey[600],
  //                     fontSize: 14,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 4),
  //                 Text(
  //                   value?.toString() ?? 'Value not provided',
  //                   style: const TextStyle(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.w500,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
                // SectionTitle(title: 'Legal Information'),

                      // _buildInfoCard(
                      //     'Property Setup', hotelData['property_setup']),
                      // _buildInfoCard('Hotel Name', hotelData['hotel_name']),
                      // _buildInfoCard(
                      //     'Booking Since', hotelData['Booking_since']),
                      // SectionTitle(title: 'Contact Details'),
                      // _buildSectionTitle('Contact Details'),
                      // _buildInfoCard(
                      //     'Contact Number', hotelData['contact_number']),
                      // _buildInfoCard(
                      //     'Email Address', hotelData['email_address']),
                      // SectionTitle(title: 'Location'),
                      // _buildSectionTitle('Location'),
                      // _buildInfoCard('City', hotelData['city']),
                      // _buildInfoCard('State', hotelData['state']),
                      // _buildInfoCard('Country', hotelData['country']),
                      // _buildInfoCard('Pincode', hotelData['pincode']),
                      // _buildSectionTitle('Legal Information'),
                        // Consumer<HotelProvider>(
                      //   builder: (context, provider, child) {
                      //     if (provider.isUploading) {
                      //       return const Center(
                      //           child: CircularProgressIndicator());
                      //     }
                      //     if (provider.imageUrls.isEmpty) {
                      //       return Container(
                      //         padding: const EdgeInsets.all(16),
                      //         decoration: BoxDecoration(
                      //           color: Colors.grey[100],
                      //           borderRadius: BorderRadius.circular(12),
                      //         ),
                      //         child: const Center(
                      //           child: Text('No images uploaded yet.'),
                      //         ),
                      //       );
                      //     }
                      //     return SizedBox(
                      //       height: 150,
                      //       child: ListView.builder(
                      //         scrollDirection: Axis.horizontal,
                      //         itemCount: provider.imageUrls.length,
                      //         itemBuilder: (context, index) {
                      //           return Padding(
                      //             padding: const EdgeInsets.only(right: 12),
                      //             child: Column(
                      //               children: [
                      //                 Container(
                      //                   decoration: BoxDecoration(
                      //                     borderRadius:
                      //                         BorderRadius.circular(12),
                      //                     boxShadow: [
                      //                       BoxShadow(
                      //                         color:
                      //                             Colors.black.withOpacity(0.1),
                      //                         blurRadius: 8,
                      //                         offset: const Offset(0, 4),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                   child: ClipRRect(
                      //                     borderRadius:
                      //                         BorderRadius.circular(12),
                      //                     child: Image.network(
                      //                       provider.imageUrls[index],
                      //                       width: 120,
                      //                       height: 120,
                      //                       fit: BoxFit.cover,
                      //                       errorBuilder:
                      //                           (context, error, stackTrace) {
                      //                         return Container(
                      //                           width: 120,
                      //                           height: 120,
                      //                           color: Colors.grey[200],
                      //                           child: const Icon(Icons.error),
                      //                         );
                      //                       },
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 const SizedBox(height: 8),
                      //                 Text(
                      //                   'Image ${index + 1}',
                      //                   style: TextStyle(
                      //                     color: Colors.grey[600],
                      //                     fontSize: 12,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           );
                      //         },
                      //       ),
                      //     );
                      //   },
                      // ),
                      // Widget _buildFacilityChip(String title, bool value) {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //     decoration: BoxDecoration(
  //       color: value ? Colors.green[50] : Colors.red[50],
  //       borderRadius: BorderRadius.circular(20),
  //       border: Border.all(
  //         color: value ? Colors.green[100]! : Colors.red[100]!,
  //       ),
  //     ),
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Icon(
  //           value ? Icons.check_circle : Icons.cancel,
  //           size: 16,
  //           color: value ? Colors.green[700] : Colors.red[700],
  //         ),
  //         const SizedBox(width: 6),
  //         Text(
  //           title,
  //           style: TextStyle(
  //             color: value ? Colors.green[700] : Colors.red[700],
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }