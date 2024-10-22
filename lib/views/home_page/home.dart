import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/field_information/hotel_provider.dart';
import 'package:hotel_side/views/auth/route_page.dart';
import 'package:hotel_side/views/profile/profile_items.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_service/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final hotelProvider = Provider.of<HotelProvider>(context,
        listen: false); // Access the HotelProvider

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${authService.currentUser?.email ?? 'User'}!'),
            const SizedBox(height: 16),
            FutureBuilder<Map<String, dynamic>?>(
              future: hotelProvider
                  .getCurrentHotelDetails(), // Call to fetch current hotel details
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
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            InfoItem(
                              icon: Icons.hotel,
                              title: 'Hotel Name',
                              value: hotelDetails['hotel_name'] ?? 'hotel name',
                            ),
                            InfoItem(
                              icon: Icons.person,
                              title: 'Nick Name',
                              value: 'r.denial',
                            ),
                            InfoItem(
                              icon: Icons.location_on,
                              title: 'Location',
                              value:
                                  '${hotelDetails['city']},${hotelDetails['state']}',
                            ),
                            InfoItem(
                              icon: Icons.work,
                              title: 'Occupation',
                              value: 'Software Developer',
                            ),
                            InfoItem(
                              icon: Icons.phone,
                              title: 'Contact Number',
                              value: hotelDetails['contact_number'],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                  // return Column(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //         'Hotel Name: ${hotelDetails['hotel_name'] ?? 'N/A'}'),
                  //     Text(
                  //         'Hotel Type: ${hotelDetails['hotel_type'] ?? 'N/A'}'),
                  //     Text('City: ${hotelDetails['city'] ?? 'N/A'}'),
                  //     Text('Country: ${hotelDetails['country'] ?? 'N/A'}'),
                  //     // Add more hotel details here
                  //   ],
                  // );
                }
              },
            ),
            ElevatedButton(
              child: const Text('Sign Out'),
              onPressed: () async {
                await authService.signOut();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AuthSelectionPage(),
                ));
              },
            ),
            // const SizedBox(height: 16),
            // ElevatedButton(
            //   child: const Text('Sign Out'),
            //   onPressed: () async {
            //     await authService.signOut();
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
