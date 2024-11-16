import 'package:flutter/material.dart';
import 'package:hotel_side/constants/colors/colors.dart';
import 'package:hotel_side/views/dashboard/grid_container/custom_card.dart';
import 'package:hotel_side/views/dashboard/grid_container/pecentage.dart';
import 'package:hotel_side/views/dashboard/recent_bookings/recent_bookings.dart';
import 'package:hotel_side/views/dashboard/rooms_section/rooms_card.dart';
import 'package:hotel_side/views/dashboard/welcome_card/welcome_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              EnhancedWelcomeCard(),

              const SizedBox(height: 24),

              // Quick Stats Grid
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  childAspectRatio: 1.1,
                ),
                children: [
                  EnhancedBookingCard(
                    icon: Icons.book,
                    iconColor: Colors.blue,
                    iconBackgroundColor: Colors.blue[100]!,
                    heading: 'Total Bookings',
                    count: 156,
                    percentageChangeWidget:
                        const PercentageChangeWidget(percentageChange: 12.5),
                    gradient: AdminColors.bookingcardcolor,
                  ),
                  EnhancedBookingCard(
                    icon: Icons.hotel,
                    iconColor: Colors.red,
                    iconBackgroundColor: Colors.red[100]!,
                    heading: 'Available Rooms',
                    count: 24,
                    // percentageChangeWidget:
                    //     const PercentageChangeWidget(percentageChange: 12.5),
                    gradient: AdminColors.availablecardcolor,
                  ),
                  EnhancedBookingCard(
                    icon: Icons.money,
                    iconColor: Colors.green,
                    iconBackgroundColor: Colors.green[100]!,
                    heading: 'Total Revenue',
                    count: 26000,
                    // percentageChangeWidget:
                    //     const PercentageChangeWidget(percentageChange: 2.5),
                    gradient: AdminColors.revenuecardcolor,
                  ),
                  EnhancedBookingCard(
                    icon: Icons.pie_chart,
                    iconColor: Colors.orange,
                    iconBackgroundColor: Colors.orange[100]!,
                    heading: 'Occupancy',
                    count: 156,
                    // percentageChangeWidget:
                    //     const PercentageChangeWidget(percentageChange: 12.5),
                    gradient: AdminColors.occcupancycardcolor,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Analytics Overview
              // const AnalyticChart(),
              // const SizedBox(height: 24),
              // // Revenue Chart
              // const RevenueGraph(),
              // const SizedBox(height: 24),

              // Room Status
              const RoomStatusCard(),

              const SizedBox(height: 24),

              // Recent Bookings
              const RecentBookings(),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}





 // Available Rooms Card
                  // Card(
                  //   elevation: 2,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(13),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         const Icon(Icons.hotel,
                  //             color: Colors.green, size: 24),
                  //         const Spacer(),
                  //         const Text(
                  //           '24',
                  //           style: TextStyle(
                  //             fontSize: 24,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //         Text(
                  //           'Available Rooms',
                  //           style: TextStyle(
                  //             color: Colors.grey[600],
                  //             fontSize: 14,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  // // Revenue Card
                  // Card(
                  //   elevation: 2,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(13),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         const Icon(Icons.money,
                  //             color: Colors.orange, size: 24),
                  //         const Spacer(),
                  //         const Text(
                  //           '₹45,250',
                  //           style: TextStyle(
                  //             fontSize: 24,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //         Text(
                  //           'Revenue',
                  //           style: TextStyle(
                  //             color: Colors.grey[600],
                  //             fontSize: 14,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  // // Occupancy Card
                  // Card(
                  //   elevation: 2,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(13),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         const Icon(Icons.pie_chart,
                  //             color: Colors.purple, size: 24),
                  //         const Spacer(),
                  //         const Text(
                  //           '78%',
                  //           style: TextStyle(
                  //             fontSize: 24,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //         Text(
                  //           'Occupancy Rate',
                  //           style: TextStyle(
                  //             color: Colors.grey[600],
                  //             fontSize: 14,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                            // Bookings Card
                  // Card(
                  //   elevation: 2,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(13),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         const Icon(Icons.book, color: Colors.blue, size: 24),
                  //         const Spacer(),
                  //         const Text(
                  //           '156',
                  //           style: TextStyle(
                  //             fontSize: 24,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //         Text(
                  //           'Total Bookings',
                  //           style: TextStyle(
                  //             color: Colors.grey[600],
                  //             fontSize: 14,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                    // Card(
              //   elevation: 2,
              //   child: Padding(
              //     padding: const EdgeInsets.all(16),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         const Text(
              //           'Room Status',
              //           style: TextStyle(
              //             fontSize: 18,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //         const SizedBox(height: 16),
              //         ListView(
              //           shrinkWrap: true,
              //           physics: const NeverScrollableScrollPhysics(),
              //           children: [
              //             ListTile(
              //               leading: const Icon(Icons.hotel),
              //               title: const Text('Room 101'),
              //               subtitle: const Text('Occupied'),
              //               trailing: Container(
              //                 width: 12,
              //                 height: 12,
              //                 decoration: const BoxDecoration(
              //                   shape: BoxShape.circle,
              //                   color: Colors.red,
              //                 ),
              //               ),
              //             ),
              //             ListTile(
              //               leading: const Icon(Icons.hotel),
              //               title: const Text('Room 102'),
              //               subtitle: const Text('Available'),
              //               trailing: Container(
              //                 width: 12,
              //                 height: 12,
              //                 decoration: const BoxDecoration(
              //                   shape: BoxShape.circle,
              //                   color: Colors.green,
              //                 ),
              //               ),
              //             ),
              //             ListTile(
              //               leading: const Icon(Icons.hotel),
              //               title: const Text('Room 103'),
              //               subtitle: const Text('Available'),
              //               trailing: Container(
              //                 width: 12,
              //                 height: 12,
              //                 decoration: const BoxDecoration(
              //                   shape: BoxShape.circle,
              //                   color: Colors.green,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //         TextButton(
              //           onPressed: () {},
              //           child: const Text('View All Rooms'),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
                       // const Card(
              //   elevation: 2,
              //   child: Padding(
              //     padding: EdgeInsets.all(16),
              //     child: Row(
              //       children: [
              //         Expanded(
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text(
              //                 'Welcome Back,\nAdmin!',
              //                 style: TextStyle(
              //                   fontSize: 24,
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //               ),
              //               // Text(
              //               //   DateFormat('EEEE, dd MMMM yyyy')
              //               //       .format(DateTime.now()),
              //               //   style: TextStyle(
              //               //     color: Colors.grey[600],
              //               //     fontSize: 14,
              //               //   ),
              //               // ),
              //             ],
              //           ),
              //         ),
              //         // ElevatedButton(
              //         //   onPressed: () {},
              //         //   child: const Text('View Reports'),
              //         // ),
              //       ],
              //     ),
              //   ),
              // ),
                  // appBar: AppBar(
      //   title: const Text('Dashboard'),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.notifications),
      //       onPressed: () {},
      //     ),
      //     IconButton(
      //       icon: const Icon(Icons.person),
      //       onPressed: () {},
      //     ),
      //   ],
      // ),