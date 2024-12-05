// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/room_controller/roomprovider.dart';
import 'package:hotel_side/views/edit_rooms/edit_rooms.dart';
import 'package:hotel_side/views/rooms_list/room_detail_view/room_detail_card.dart';
import 'package:hotel_side/widgets/home_page_widgets/alert_box.dart';
import 'package:provider/provider.dart';

class RoomDetailPage extends StatelessWidget {
  const RoomDetailPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context, listen: false);
    return Consumer<RoomProvider>(builder: (context, provider, child) {
      final roomDetails = provider.selectedRoom;
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
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  child: const Text('Edit'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RoomEditingPage(),
                    ));
                  },
                ),
                PopupMenuItem<String>(
                  child: const Text('Delete'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CustomAlertDialog(
                          contentText: 'Are you sure to delete the room?',
                          titleText: 'Delete Room',
                          buttonText1: 'Yes',
                          buttonText2: 'No',
                          onPressButton1: () async {
                            await roomProvider
                                .deleteRoom(roomDetails!['room_id']);
                            provider.clearSelectedRoom();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          onPressButton2: () {
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            )
          ],
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: RoomDetailCard(),
        ),
      );
    });
  }
}
