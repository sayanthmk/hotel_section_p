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
                    gradient: AdminColors.availablecardcolor,
                  ),
                  EnhancedBookingCard(
                    icon: Icons.money,
                    iconColor: Colors.green,
                    iconBackgroundColor: Colors.green[100]!,
                    heading: 'Total Revenue',
                    count: 26000,
                    gradient: AdminColors.revenuecardcolor,
                  ),
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
              const SizedBox(height: 24),
              const RecentBookings(),
            ],
          ),
        ),
      ),
    );
  }
}
