import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/auth_service/auth_service.dart';
import 'package:hotel_side/controllers/field_information/hotel_provider.dart';
import 'package:hotel_side/views/auth/route_page.dart';
import 'package:hotel_side/views/add_rooms/property_description.dart';
import 'package:hotel_side/views/add_rooms/rooms_list.dart';
import 'package:provider/provider.dart';

class SuccessScreen extends StatelessWidget {
  // final String? hotelId; // Store the hotel ID

  const SuccessScreen({
    super.key,
  }); // Update constructor

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final hotelservice = Provider.of<HotelProvider>(context);
    String? userid = hotelservice.getUserId();
    return Scaffold(
      appBar: AppBar(title: const Text('Success')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome",
              style: TextStyle(fontSize: 24),
            ),
            Text('Welcome, ${authService.currentUser?.email ?? 'User'}!'),
            // Text('Hotel ID: ${hotelId ?? 'Not available'}'), // Display hotel ID
            Text('the id is : $userid'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to PropertyDescription
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PropertyDescription(),
                  ),
                );
              },
              child: const Text('Add Rooms'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to RoomListPage
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RoomListPage(),
                  ),
                );
              },
              child: const Text('Rooms List'),
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
          ],
        ),
      ),
    );
  }
}
