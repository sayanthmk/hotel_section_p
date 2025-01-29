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
              offset: const Offset(0, 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              color: const Color(0xFFFFFBF8),
              icon: const Icon(
                Icons.more_vert,
                color: Color(0xFF7D5A50),
              ),
              position: PopupMenuPosition.under,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF7D5A50).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.edit_outlined,
                            color: Color(0xFF7D5A50),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF5E4238),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    // Adding a slight delay to avoid navigation conflict with popup menu
                    Future.delayed(const Duration(milliseconds: 100), () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RoomEditingPage(),
                      ));
                    });
                  },
                ),
                PopupMenuItem<String>(
                  height: 2,
                  enabled: false,
                  child: Divider(
                    color: const Color(0xFF9C7B73).withOpacity(0.2),
                    height: 2,
                  ),
                ),
                PopupMenuItem<String>(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4A373).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.delete_outline,
                            color: Color(0xFFD4A373),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Delete',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFFD4A373),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Future.delayed(const Duration(milliseconds: 100), () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomAlertDialog(
                            // icon: Icons.delete_outline,
                            titleText: 'Delete Room',
                            contentText:
                                'Are you sure you want to delete this room? This action cannot be undone.',
                            buttonText1: 'Cancel',
                            buttonText2: 'Delete',
                            // accentColor: const Color(0xFFD4A373),
                            onPressButton1: () {
                              Navigator.of(context).pop();
                            },
                            onPressButton2: () async {
                              await roomProvider
                                  .deleteRoom(roomDetails!['room_id']);
                              provider.clearSelectedRoom();
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      );
                    });
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
