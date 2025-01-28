// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class RecentBookings extends StatelessWidget {
//   const RecentBookings({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Recent Bookings',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             ListView(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               children: [
//                 ListTile(
//                   leading: const CircleAvatar(
//                     child: Icon(Icons.person),
//                   ),
//                   title: const Text('Guest 1'),
//                   subtitle: const Text('Room 101'),
//                   trailing: Text(
//                     DateFormat('MMM dd').format(DateTime.now()),
//                   ),
//                 ),
//                 ListTile(
//                   leading: const CircleAvatar(
//                     child: Icon(Icons.person),
//                   ),
//                   title: const Text('Guest 2'),
//                   subtitle: const Text('Room 102'),
//                   trailing: Text(
//                     DateFormat('MMM dd').format(
//                       DateTime.now().subtract(const Duration(days: 1)),
//                     ),
//                   ),
//                 ),
//                 ListTile(
//                   leading: const CircleAvatar(
//                     child: Icon(Icons.person),
//                   ),
//                   title: const Text('Guest 3'),
//                   subtitle: const Text('Room 103'),
//                   trailing: Text(
//                     DateFormat('MMM dd').format(
//                       DateTime.now().subtract(const Duration(days: 2)),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             TextButton(
//               onPressed: () {},
//               child: const Text('View All Bookings'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
