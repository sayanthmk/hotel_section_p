import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/field_information/hotel_provider.dart';
import 'package:hotel_side/views/profile/profile_items.dart';
import 'package:provider/provider.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<HotelProvider>(context,
        listen: false); // Access the HotelProvider

    return FutureBuilder<Map<String, dynamic>?>(
      future: hotelProvider
          .fetchHotelDetailsBasedOnStatus(), // Call to fetch current hotel details
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Loading indicator
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Show error if any
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Text(
              'No hotel details available.'); // Show if no hotel details
        } else {
          // Extract hotel data from the snapshot
          final hotelDetails = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    InfoItem(
                      icon: Icons.hotel,
                      title: 'Hotel Name',
                      value: hotelDetails['hotel_name'] ?? 'hotel name',
                    ),
                    InfoItem(
                      icon: Icons.villa,
                      title: 'Hotel Type',
                      value: hotelDetails['hotel_type'] ?? 'hotel type',
                      // value: 'hotel_type',
                    ),
                    InfoItem(
                      icon: Icons.location_on,
                      title: 'Location',
                      value: '${hotelDetails['city']},${hotelDetails['state']}',
                    ),
                    InfoItem(
                      icon: Icons.phone,
                      title: 'Contact Number',
                      value: hotelDetails['contact_number'],
                    ),
                    InfoItem(
                      icon: Icons.post_add,
                      title: 'Pincode',
                      value: hotelDetails['pincode'].toString(),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:hotel_side/controllers/field_information/hotel_provider.dart';
// import 'package:hotel_side/views/profile/profile_items.dart';
// import 'package:provider/provider.dart';

// class ProfileCard extends StatelessWidget {
//   const ProfileCard({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final hotelProvider = Provider.of<HotelProvider>(context);
//     final hotelData = hotelProvider.hotelData;
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Card(
//         elevation: 5,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             children: [
//               InfoItem(
//                 icon: Icons.hotel,
//                 title: 'Hotel Name',
//                 value: hotelData['hotel_name'] ?? 'hotel name',
//               ),
//               InfoItem(
//                 icon: Icons.person,
//                 title: 'Nick Name',
//                 value: 'r.denial',
//               ),
//               InfoItem(
//                 icon: Icons.location_on,
//                 title: 'Location',
//                 value: '${hotelData['city']},${hotelData['state']}',
//               ),
//               InfoItem(
//                 icon: Icons.work,
//                 title: 'Occupation',
//                 value: 'Software Developer',
//               ),
//               InfoItem(
//                 icon: Icons.phone,
//                 title: 'Contact Number',
//                 value: hotelData['contact_number'],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }