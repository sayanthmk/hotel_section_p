import 'package:flutter/material.dart';
import 'package:hotel_side/views/dashboard/rooms_section/person_detail.dart';
import 'package:hotel_side/views/rooms_list/rooms_list.dart';

class RoomStatusCard extends StatelessWidget {
  const RoomStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey[50]!,
                Colors.grey[100]!,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.meeting_room,
                            color: Colors.blue[700],
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Room Status',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Current Occupancy',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: Colors.green[400],
                            size: 12,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '67% Available',
                            style: TextStyle(
                              color: Colors.blue[700],
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    RoomTile(
                      room: 'Room 101',
                      status: 'Occupied',
                      isOccupied: true,
                      guestName: 'John Doe',
                      checkOut: 'Check-out: 12 Oct',
                      type: 'Deluxe Suite',
                      price: '\$200/night',
                    ),
                    const Divider(height: 1),
                    RoomTile(
                      room: 'Room 101',
                      status: 'Occupied',
                      isOccupied: false,
                      guestName: 'John Doe',
                      checkOut: 'Check-out: 12 Oct',
                      type: 'Deluxe Suite',
                      price: '\$200/night',
                    ),
                    const Divider(height: 1),
                    RoomTile(
                      room: 'Room 101',
                      status: 'Occupied',
                      isOccupied: false,
                      guestName: 'John Doe',
                      checkOut: 'Check-out: 12 Oct',
                      type: 'Deluxe Suite',
                      price: '\$200/night',
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RoomListPage(),
                        ));
                      },
                      icon: const Icon(Icons.view_list),
                      label: const Text('View All Rooms'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue[700],
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildRoomTile({
  //   required String room,
  //   required String status,
  //   required bool isOccupied,
  //   String? guestName,
  //   String? checkOut,
  //   String? type,
  //   String? price,
  // }) {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(vertical: 12),
  //     child: Row(
  //       children: [
  //         Container(
  //           padding: const EdgeInsets.all(8),
  //           decoration: BoxDecoration(
  //             color: isOccupied ? Colors.red[50] : Colors.green[50],
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //           child: Icon(
  //             Icons.hotel,
  //             color: isOccupied ? Colors.red[400] : Colors.green[400],
  //             size: 24,
  //           ),
  //         ),
  //         const SizedBox(width: 16),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Row(
  //                 children: [
  //                   Text(
  //                     room,
  //                     style: const TextStyle(
  //                       fontWeight: FontWeight.w600,
  //                       fontSize: 16,
  //                     ),
  //                   ),
  //                   const SizedBox(width: 8),
  //                   Container(
  //                     padding: const EdgeInsets.symmetric(
  //                       horizontal: 8,
  //                       vertical: 2,
  //                     ),
  //                     decoration: BoxDecoration(
  //                       color: isOccupied ? Colors.red[50] : Colors.green[50],
  //                       borderRadius: BorderRadius.circular(12),
  //                     ),
  //                     child: Text(
  //                       status,
  //                       style: TextStyle(
  //                         color:
  //                             isOccupied ? Colors.red[700] : Colors.green[700],
  //                         fontSize: 12,
  //                         fontWeight: FontWeight.w500,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 4),
  //               if (guestName != null)
  //                 Text(
  //                   guestName,
  //                   style: TextStyle(
  //                     color: Colors.grey[600],
  //                     fontSize: 14,
  //                   ),
  //                 ),
  //               if (checkOut != null)
  //                 Text(
  //                   checkOut,
  //                   style: TextStyle(
  //                     color: Colors.grey[600],
  //                     fontSize: 14,
  //                   ),
  //                 ),
  //               if (type != null)
  //                 Text(
  //                   type,
  //                   style: TextStyle(
  //                     color: Colors.grey[600],
  //                     fontSize: 14,
  //                   ),
  //                 ),
  //               if (price != null)
  //                 Text(
  //                   price,
  //                   style: TextStyle(
  //                     color: Colors.grey[600],
  //                     fontSize: 14,
  //                   ),
  //                 ),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           width: 12,
  //           height: 12,
  //           decoration: BoxDecoration(
  //             shape: BoxShape.circle,
  //             color: isOccupied ? Colors.red[400] : Colors.green[400],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
 // Container(
                    //   padding: const EdgeInsets.symmetric(
                    //     horizontal: 12,
                    //     vertical: 6,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     color: Colors.orange[50],
                    //     borderRadius: BorderRadius.circular(20),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       Icon(
                    //         Icons.cleaning_services,
                    //         color: Colors.orange[700],
                    //         size: 16,
                    //       ),
                    //       const SizedBox(width: 6),
                    //       Text(
                    //         '2 Rooms Need Cleaning',
                    //         style: TextStyle(
                    //           color: Colors.orange[700],
                    //           fontWeight: FontWeight.w500,
                    //           fontSize: 14,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                     // _buildRoomTile(
                    //   room: "Room 101",
                    //   status: "Occupied",
                    //   isOccupied: true,
                    //   guestName: "John Smith",
                    //   checkOut: "Check-out: 2:00 PM",
                    // ),
                    // const Divider(height: 1),
                    // _buildRoomTile(
                    //   room: "Room 102",
                    //   status: "Available",
                    //   isOccupied: false,
                    //   type: "Deluxe Room",
                    //   price: "\$199/night",
                    // ),
                    // const Divider(height: 1),
                    // _buildRoomTile(
                    //   room: "Room 103",
                    //   status: "Available",
                    //   isOccupied: false,
                    //   type: "Suite",
                    //   price: "\$299/night",
                    // ),