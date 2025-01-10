import 'package:flutter/material.dart';
import 'package:hotel_side/constants/colors/colors.dart';
import 'package:hotel_side/controllers/booking_provider/booking_provider.dart';
import 'package:hotel_side/controllers/room_controller/roomprovider.dart';
import 'package:hotel_side/views/dashboard/grid_container/custom_card.dart';
import 'package:hotel_side/views/dashboard/grid_container/pecentage.dart';
import 'package:hotel_side/views/dashboard/rooms_section/rooms_card.dart';
import 'package:hotel_side/views/dashboard/welcome_card/welcome_card.dart';
import 'package:hotel_side/views/rooms_list/rooms_list.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context);
    final roomCount = roomProvider.roomList.length;
    final bookingprovider =
        Provider.of<BookingProvider>(context, listen: false);
    final bookingCount = bookingprovider.bookingList.length;
    // final totalamount=bookingprovider.getPaymentTotal();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const EnhancedWelcomeCard(),
              const SizedBox(height: 24),
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
                    count: bookingCount,
                    percentageChangeWidget:
                        const PercentageChangeWidget(percentageChange: 12.5),
                    gradient: AdminColors.bookingcardcolor,
                  ),
                  EnhancedBookingCard(
                    ontap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const RoomListPage(),
                        ),
                      );
                    },
                    icon: Icons.hotel,
                    iconColor: Colors.red,
                    iconBackgroundColor: Colors.red[100]!,
                    heading: 'Available Rooms',
                    count: roomCount,
                    gradient: AdminColors.availablecardcolor,
                  ),
                  FutureBuilder<double>(
                    future: bookingprovider.getPaymentTotal(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: EnhancedBookingCard(
                            icon: Icons.money,
                            iconColor: Colors.green,
                            iconBackgroundColor: Colors.green[100]!,
                            heading: 'Total Revenue',
                            count: 0, // Display as an integer
                            gradient: AdminColors.revenuecardcolor,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final totalAmount = snapshot.data ?? 0.0;
                        return EnhancedBookingCard(
                          icon: Icons.money,
                          iconColor: Colors.green,
                          iconBackgroundColor: Colors.green[100]!,
                          heading: 'Total Revenue',
                          count: totalAmount.toInt(),
                          gradient: AdminColors.revenuecardcolor,
                        );
                      }
                    },
                  ),
                  // EnhancedBookingCard(
                  //   icon: Icons.money,
                  //   iconColor: Colors.green,
                  //   iconBackgroundColor: Colors.green[100]!,
                  //   heading: 'Total Revenue',
                  //   count: totalamount,
                  //   gradient: AdminColors.revenuecardcolor,
                  // ),
                  EnhancedBookingCard(
                    icon: Icons.pie_chart,
                    iconColor: Colors.orange,
                    iconBackgroundColor: Colors.orange[100]!,
                    heading: 'Occupancy',
                    count: 156,
                    gradient: AdminColors.occcupancycardcolor,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const RoomStatusCard(),
              // const SizedBox(height: 24),
              // const RecentBookings(),
            ],
          ),
        ),
      ),
    );
  }
}
