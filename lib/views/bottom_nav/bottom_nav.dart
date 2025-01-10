import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/widgets_controller/widgets_controller.dart';
import 'package:hotel_side/views/bookings/bookings_list_page/bookings_list.dart';
import 'package:hotel_side/views/dashboard/hotel_dash.dart';
import 'package:hotel_side/views/profile/profile_page.dart';
import 'package:hotel_side/views/reviews/reviews_page.dart';
import 'package:provider/provider.dart';

class BottomNavScreen extends StatelessWidget {
  final List<Widget> pages = [
    const DashboardPage(),
    const BookingsList(),
    const ReviewListPage(),
    const UserProfileScreen(),
  ];

  BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WidgetsController>(context);

    return Scaffold(
      body: pages[provider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: provider.currentIndex,
        onTap: (index) {
          provider.setIndex(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rate_review),
            label: 'Rating',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
