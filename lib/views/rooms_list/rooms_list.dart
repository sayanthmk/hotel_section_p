import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/room_controller/roomprovider.dart';
import 'package:hotel_side/views/add_rooms/room_type/room_type_sel.dart';
import 'package:hotel_side/views/rooms_list/widgets/room_appbar.dart';
import 'package:hotel_side/views/rooms_list/widgets/room_card.dart';
import 'package:hotel_side/views/rooms_list/widgets/states.dart';
import 'package:provider/provider.dart';

class RoomListPage extends StatelessWidget {
  const RoomListPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  provider.setSelectedRoom(index);
                  return const RoomCard();
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
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
