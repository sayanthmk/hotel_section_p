import 'dart:developer';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:hotel_side/views/bookings/bookings_list_page/bookings_list.dart';
import 'package:hotel_side/views/dashboard/hotel_dash.dart';
import 'package:hotel_side/views/profile/profile_page.dart';
import 'package:hotel_side/views/reviews/reviews_page.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  final _pageController = PageController(initialPage: 0);

  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 0);

  int maxCount = 5;

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> bottomBarPages = [
      const DashboardPage(),
      const BookingsList(),
      const ReviewListPage(),
      const UserProfileScreen(),
    ];
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              notchBottomBarController: _controller,
              color: Colors.white,
              showLabel: true,
              textOverflow: TextOverflow.visible,
              maxLine: 1,
              shadowElevation: 5,
              kBottomRadius: 28.0,
              removeMargins: false,
              bottomBarWidth: 500,
              showShadow: false,
              durationInMilliSeconds: 300,
              itemLabelStyle: const TextStyle(fontSize: 10),
              elevation: 1,
              bottomBarItems: const [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.home_filled,
                  ),
                  itemLabel: 'Home',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.book_online,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.book_online_outlined,
                  ),
                  itemLabel: 'Bookings',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.rate_review,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.rate_review_outlined,
                    // color: Colors.pink,
                  ),
                  itemLabel: 'Rating',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.person,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.person,
                    // color: Colors.yellow,
                  ),
                  itemLabel: 'Profile',
                ),
              ],
              onTap: (index) {
                log('current selected index $index');
                _pageController.jumpToPage(index);
              },
              kIconSize: 24.0,
            )
          : null,
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:hotel_side/controllers/widgets_controller/widgets_controller.dart';
// import 'package:hotel_side/views/bookings/bookings_list_page/bookings_list.dart';
// import 'package:hotel_side/views/dashboard/hotel_dash.dart';
// import 'package:hotel_side/views/profile/profile_page.dart';
// import 'package:hotel_side/views/reviews/reviews_page.dart';
// import 'package:provider/provider.dart';

// class BottomNavScreen extends StatelessWidget {
//   final List<Widget> pages = [
//     const DashboardPage(),
//     const BookingsList(),
//     const ReviewListPage(),
//     const UserProfileScreen(),
//   ];

//   BottomNavScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<WidgetsController>(context);

//     return Scaffold(
//       body: pages[provider.currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.grey,
//         currentIndex: provider.currentIndex,
//         onTap: (index) {
//           provider.setIndex(index);
//         },
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.book_online),
//             label: 'Bookings',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.rate_review),
//             label: 'Rating',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }