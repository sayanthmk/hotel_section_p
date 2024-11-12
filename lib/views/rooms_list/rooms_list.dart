import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/field_information/roomprovider.dart';
import 'package:hotel_side/views/add_rooms/room_type.dart';
import 'package:hotel_side/views/rooms_list/widgets/room_appbar.dart';
import 'package:hotel_side/views/rooms_list/widgets/room_card.dart';
import 'package:hotel_side/views/rooms_list/widgets/states.dart';
import 'package:provider/provider.dart';

class RoomListPage extends StatelessWidget {
  const RoomListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtain the provider outside FutureBuilder
    final roomProvider = Provider.of<RoomProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FF),
      appBar: const CustomAppBar(),
      body: FutureBuilder(
        future: roomProvider.getRooms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingState();
          } else if (snapshot.hasError) {
            return const ErrorState();
          }
          return Consumer<RoomProvider>(
            builder: (context, provider, child) {
              final rooms = provider.roomList;

              if (rooms.isEmpty) {
                return const EmptyState();
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  return RoomCard(room: rooms[index]);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => RoomTypeSelection(),
            ),
          );
        },
        backgroundColor: const Color(0xff1E91B6),
        child: const Icon(Icons.add),
      ),
    );
  }
}



// 



// class RoomPriceSection extends StatelessWidget {
//   final dynamic price;

//   const RoomPriceSection({
//     super.key,
//     required this.price,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           '₹${price.toString()}',
//           style: const TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF1E91B6),
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             // Implement booking functionality
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFF1E91B6),
//             foregroundColor: Colors.white,
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//           child: const Text('View Details'),
//         ),
//       ],
//     );
//   }
// }



// class LoadingState extends StatelessWidget {
//   const LoadingState({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: CircularProgressIndicator(
//         color: Color(0xFF1E91B6),
//       ),
//     );
//   }
// }


// class RoomListView extends StatelessWidget {
//   final List<Map<String, dynamic>> rooms;

//   const RoomListView({
//     super.key,
//     required this.rooms,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: rooms.length,
//       itemBuilder: (context, index) {
//         return RoomCard(room: rooms[index]);
//       },
//     );
//   }
// }



// class RoomImage extends StatelessWidget {
//   final List<dynamic> imageUrl;

//   const RoomImage({
//     super.key,
//     required this.imageUrl,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       decoration: BoxDecoration(
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
//         image: imageUrl.isNotEmpty
//             ? DecorationImage(
//                 image: NetworkImage(imageUrl[0]),
//                 fit: BoxFit.cover,
//               )
//             : null,
//       ),
//       child: imageUrl.isEmpty
//           ? const Center(
//               child: Icon(
//                 Icons.image,
//                 size: 50,
//                 color: Colors.grey,
//               ),
//             )
//           : null,
//     );
//   }
// }
// class RoomTypeHeader extends StatelessWidget {
//   final Map<String, dynamic> room;

//   const RoomTypeHeader({
//     super.key,
//     required this.room,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           decoration: BoxDecoration(
//             color: const Color(0xFF1E91B6).withOpacity(0.1),
//             borderRadius: BorderRadius.circular(6),
//           ),
//           child: Text(
//             room['room_type'] ?? 'Standard Room',
//             style: const TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//               color: Color(0xFF1E91B6),
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           room['accommodation_type'],
//           style: const TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF2D3748),
//           ),
//         ),
//         const SizedBox(height: 4),
//         Row(
//           children: [
//             const Icon(
//               Icons.square_foot,
//               size: 16,
//               color: Color(0xFF718096),
//             ),
//             const SizedBox(width: 4),
//             Text(
//               '${room['room_area']} sq ft',
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Color(0xFF718096),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }