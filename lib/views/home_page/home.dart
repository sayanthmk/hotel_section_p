import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/hotel_provider/hotel_provider.dart';
import 'package:hotel_side/views/auth/route_page.dart';
import 'package:hotel_side/views/profile/profile_items.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_service/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final hotelProvider = Provider.of<HotelProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${authService.currentUser?.email ?? 'User'}!'),
            const SizedBox(height: 16),
            FutureBuilder<String?>(
              future: hotelProvider.hotelPermission(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data != null) {
                  return Container(
                    width: 200,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Hotel is Permitted',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  return Container(
                    width: 200,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Hotel is Not Permitted',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            FutureBuilder<Map<String, dynamic>?>(
              future: hotelProvider.getCurrentHotelDetails(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Text('No hotel details available.');
                } else {
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
                              icon: Icons.location_on,
                              title: 'Location',
                              value:
                                  '${hotelDetails['city']},${hotelDetails['state']}',
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
                }
              },
            ),
            ElevatedButton(
              child: const Text('Sign Out'),
              onPressed: () async {
                await authService.signOut();
                // ignore: use_build_context_synchronously
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AuthSelectionPage(),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
