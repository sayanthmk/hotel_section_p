import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/room_controller/roomprovider.dart';
import 'package:hotel_side/models/booking_model.dart';
import 'package:hotel_side/views/bookings/booking_detail_page/widgets/book_det_date.dart';
import 'package:hotel_side/views/bookings/booking_detail_page/widgets/book_det_info.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookingDetailCard extends StatelessWidget {
  const BookingDetailCard({
    super.key,
    required this.bookingDetails,
  });

  final BookingSectionModel? bookingDetails;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<RoomProvider>(context, listen: false)
          .getRoomById(bookingDetails!.roomId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error loading room details: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        return Consumer<RoomProvider>(
          builder: (context, roomProvider, _) {
            final roomDetails = roomProvider.selectedRoom;

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          'Booking ID: ${bookingDetails?.bookId}'
                              .toUpperCase()
                              .substring(0, 23),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // if (roomDetails != null &&
                  //     roomDetails['room_images'] != null &&
                  //     (roomDetails['room_images'] as List).isNotEmpty)
                  // Padding(
                  //   padding: const EdgeInsets.all(16),
                  //   child: SizedBox(
                  //     height: 200,
                  //     child: ListView.builder(
                  //       scrollDirection: Axis.horizontal,
                  //       itemCount:
                  //           (roomDetails['room_images'] as List).length,
                  //       itemBuilder: (context, index) {
                  //         return Padding(
                  //           padding: const EdgeInsets.only(right: 8.0),
                  //           child: ClipRRect(
                  //             borderRadius: BorderRadius.circular(12),
                  //             child: Image.network(
                  //               roomDetails['room_images'][index],
                  //               fit: BoxFit.cover,
                  //               width: 280,
                  //               errorBuilder: (context, error, stackTrace) {
                  //                 return const Icon(Icons.error);
                  //               },
                  //             ),
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Card(
                      color: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Stay Details',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const Divider(height: 32),
                            BookDetailDateRow(
                              label: 'Check-in',
                              date: DateFormat('dd MMM yyyy')
                                  .format(bookingDetails!.startdate),
                              icon: Icons.login,
                              color: Colors.green,
                            ),
                            const SizedBox(height: 20),
                            BookDetailDateRow(
                              label: 'Check-out',
                              date: DateFormat('dd MMM yyyy')
                                  .format(bookingDetails!.enddate),
                              icon: Icons.logout,
                              color: Colors.red,
                            ),
                            const Divider(height: 32),
                            BookDetailInfoRow(
                              icon: Icons.people_alt_outlined,
                              label: 'Number of Adults',
                              value: bookingDetails!.numberOfAdults.toString(),
                              color: Colors.blue,
                            ),
                            const SizedBox(height: 32),
                            BookDetailInfoRow(
                              icon: Icons.people_alt_outlined,
                              label: 'Number of Childs',
                              value: bookingDetails!.numberOfChilds.toString(),
                              color: Colors.orange,
                            ),
                            const SizedBox(height: 32),
                            BookDetailInfoRow(
                              icon: Icons.money,
                              label: 'Paid Amount',
                              value: bookingDetails!.paidAmount.toString(),
                              color: Colors.pink,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (roomDetails != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Card(
                        color: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Room Details',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const Divider(height: 32),
                              BookDetailInfoRow(
                                icon: Icons.apartment,
                                label: 'Room Type',
                                value: roomDetails['room_type'] ?? 'N/A',
                                color: Colors.indigo,
                              ),
                              const SizedBox(height: 16),
                              BookDetailInfoRow(
                                icon: Icons.square_foot,
                                label: 'Room Area',
                                value: roomDetails['room_area'] ?? 'N/A',
                                color: Colors.brown,
                              ),
                              const SizedBox(height: 16),
                              BookDetailInfoRow(
                                icon: Icons.currency_rupee,
                                label: 'Base Price',
                                value: '₹${roomDetails['Base Price']}',
                                color: Colors.green,
                              ),
                              if (roomDetails['Air Conditioner'] == true ||
                                  roomDetails['Wifi'] == true ||
                                  roomDetails['Parking'] == true) ...[
                                const Divider(height: 32),
                                Text(
                                  'Amenities',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 16),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    if (roomDetails['Air Conditioner'] == true)
                                      _buildAmenityChip(
                                          'AC', Icons.ac_unit, Colors.blue),
                                    if (roomDetails['Wifi'] == true)
                                      _buildAmenityChip(
                                          'WiFi', Icons.wifi, Colors.green),
                                    if (roomDetails['Parking'] == true)
                                      _buildAmenityChip('Parking',
                                          Icons.local_parking, Colors.orange),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      color: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Guest Information',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const Divider(height: 32),
                            BookDetailInfoRow(
                              icon: Icons.person_outline,
                              label: 'Guest Name',
                              value: bookingDetails!.name,
                              color: Colors.purple,
                            ),
                            const SizedBox(height: 16),
                            BookDetailInfoRow(
                              icon: Icons.badge_outlined,
                              label: 'Room ID',
                              value: bookingDetails!.roomId,
                              color: Colors.orange,
                            ),
                            const SizedBox(height: 16),
                            BookDetailInfoRow(
                              icon: Icons.cake_outlined,
                              label: 'Age',
                              value: bookingDetails!.age.toString(),
                              color: Colors.teal,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildAmenityChip(String label, IconData icon, Color color) {
    return Chip(
      avatar: Icon(icon, size: 18, color: color),
      label: Text(label),
      backgroundColor: color.withOpacity(0.1),
      labelStyle: TextStyle(color: color),
    );
  }
}

// import 'package:flutter/material.dart';

class AmenityChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const AmenityChip({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18, color: color),
      label: Text(label),
      backgroundColor: color.withOpacity(0.1),
      labelStyle: TextStyle(color: color),
    );
  }
}
