import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/field_information/roomprovider.dart';
import 'package:hotel_side/views/edit_rooms/edit_rooms.dart';
import 'package:hotel_side/views/rooms_list/room_detail_view/room_detail_card.dart';
import 'package:provider/provider.dart';

class RoomDetailPage extends StatelessWidget {
  final Map<String, dynamic> roomDetails;

  const RoomDetailPage({super.key, required this.roomDetails});

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Room Details',
          style: TextStyle(
            color: Color(0xFF1E91B6),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            // onSelected: (value) {
            //   // Handle menu selection
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(content: Text('Selected: $value')),
            //   );
            // },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                // value: '  Edit',
                child: Text('Edit'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        RoomEditingPage(roomDetails: roomDetails),
                  ));
                },
              ),
              PopupMenuItem<String>(
                // value: 'Delete',
                child: Text('Delete'),
                onTap: () async {
                  // Directly call deleteRoom when 'Delete' is selected
                  await roomProvider.deleteRoom(roomDetails['room_id']);
                  // Optionally, show a SnackBar or navigate back after deletion
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Room deleted successfully')),
                  );
                  Navigator.of(context).pop(); // Go back after deletion
                },
              ),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RoomDetailCard(roomDetails: roomDetails),
      ),
    );
  }
}
