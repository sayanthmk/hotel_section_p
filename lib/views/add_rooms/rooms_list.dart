import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/field_information/roomprovider.dart';
import 'package:hotel_side/views/add_rooms/room_detail_view.dart';
import 'package:provider/provider.dart';

class RoomListPage extends StatelessWidget {
  const RoomListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room List'),
      ),
      body: FutureBuilder(
        future: Provider.of<RoomProvider>(context, listen: false).getRooms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching rooms'));
          }

          return Consumer<RoomProvider>(
            builder: (context, provider, child) {
              final rooms = provider.roomList;

              if (rooms.isEmpty) {
                return const Center(child: Text('No rooms available'));
              }

              return ListView.builder(
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  final room = rooms[index];

                  return ListTile(
                    title: Column(
                      children: [
                        Text('room_area: ${room['room_area']}'),
                        Text(
                            'accommodation_type: ${room['accommodation_type']}'),
                        Text('Property Size: ${room['Property Size']}'),
                        Text(
                            'Number of Extra Adults Allowed: ${room['Number of Extra Adults Allowed']}'),
                        Text(
                            'Number of Extra Child Allowed: ${room['Number of Extra Child Allowed']}'),
                      ],
                    ),
                    subtitle: Text('Price: ${room['Base Price']}'),
                    leading: room['room_images'].isNotEmpty
                        ? Image.network(room['room_images'][0], width: 50)
                        : const Icon(Icons.image),
                    onTap: () {
                      // Navigate to the RoomDetailPage and pass room details
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RoomDetailPage(roomDetails: room),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
