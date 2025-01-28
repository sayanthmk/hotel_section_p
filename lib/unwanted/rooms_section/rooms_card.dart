// import 'package:flutter/material.dart';
// import 'package:hotel_side/views/dashboard/rooms_section/person_detail.dart';
// import 'package:hotel_side/views/rooms_list/rooms_list.dart';

// class RoomStatusCard extends StatelessWidget {
//   const RoomStatusCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 400,
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Colors.grey[50]!,
//                 Colors.grey[100]!,
//               ],
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: Colors.blue[100],
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Icon(
//                             Icons.meeting_room,
//                             color: Colors.blue[700],
//                             size: 24,
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         const Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Room Status',
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               'Current Occupancy',
//                               style: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 6,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.blue[50],
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Row(
//                         children: [
//                           Icon(
//                             Icons.circle,
//                             color: Colors.green[400],
//                             size: 12,
//                           ),
//                           const SizedBox(width: 6),
//                           Text(
//                             '67% Available',
//                             style: TextStyle(
//                               color: Colors.blue[700],
//                               fontWeight: FontWeight.w500,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 24),
//                 ListView(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   children: const [
//                     RoomTile(
//                       room: 'Room 101',
//                       status: 'Occupied',
//                       isOccupied: true,
//                       guestName: 'John Doe',
//                       checkOut: 'Check-out: 12 Oct',
//                       type: 'Deluxe Suite',
//                       price: '\$200/night',
//                     ),
//                      Divider(height: 1),
//                     RoomTile(
//                       room: 'Room 101',
//                       status: 'Occupied',
//                       isOccupied: false,
//                       guestName: 'John Doe',
//                       checkOut: 'Check-out: 12 Oct',
//                       type: 'Deluxe Suite',
//                       price: '\$200/night',
//                     ),
//                      Divider(height: 1),
//                     RoomTile(
//                       room: 'Room 101',
//                       status: 'Occupied',
//                       isOccupied: false,
//                       guestName: 'John Doe',
//                       checkOut: 'Check-out: 12 Oct',
//                       type: 'Deluxe Suite',
//                       price: '\$200/night',
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 5),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     TextButton.icon(
//                       onPressed: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => const RoomListPage(),
//                         ));
//                       },
//                       icon: const Icon(Icons.view_list),
//                       label: const Text('View All Rooms'),
//                       style: TextButton.styleFrom(
//                         foregroundColor: Colors.blue[700],
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 8,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

// }