import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/room_controller/roomprovider.dart';
import 'package:hotel_side/views/add_rooms/room_final_review/room_submission_image.dart';
import 'package:hotel_side/views/registration_page/final_review_page/widgets/faciltity_chip.dart';
import 'package:hotel_side/views/registration_page/final_review_page/widgets/info_card.dart';
import 'package:hotel_side/views/rooms_list/rooms_list.dart';
import 'package:hotel_side/widgets/home_page_widgets/button.dart';
import 'package:provider/provider.dart';

class RoomsSubmissionPage extends StatelessWidget {
  const RoomsSubmissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context);
    final roomData = roomProvider.roomData;

    final amenities = {
      'Cupboard': roomData['Cupboard'] ?? false,
      'Wardrobe': roomData['Wardrobe'] ?? false,
      'Free Breakfast': roomData['Free Breakfast'] ?? false,
      'Free Lunch': roomData['Free Lunch'] ?? false,
      'Free Dinner': roomData['Free Dinner'] ?? false,
      'Laundry': roomData['Laundry'] ?? false,
      'Elevator': roomData['Elevator'] ?? false,
      'Air Conditioner': roomData['Air Conditioner'] ?? false,
      'House Keeping': roomData['House Keeping'] ?? false,
      'Kitchen': roomData['Kitchen'] ?? false,
      'Wifi': roomData['Wifi'] ?? false,
      'Parking': roomData['Parking'] ?? false,
    };

    return Scaffold(
      backgroundColor: const Color(0xffF5F9FF),
      appBar: AppBar(title: const Text('Final Review')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Review your room details:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              InfoCard(
                title: 'Room Area',
                value: roomData['room_area'],
              ),
              InfoCard(
                title: 'Property Size',
                value: roomData['Property Size'],
              ),
              InfoCard(
                title: 'Room Type',
                value: roomData['room_type'],
              ),
              InfoCard(
                title: 'Extra Bed Types',
                value: roomData['Select Extra Bed Types'],
              ),
              InfoCard(
                title: 'Base Price',
                value: roomData['Base Price'],
              ),
              InfoCard(
                title: 'Extra Adults Allowed',
                value: roomData['Number of Extra Adults Allowed'],
              ),
              InfoCard(
                title: 'Extra Child Allowed',
                value: roomData['Number of Extra Child Allowed'],
              ),
              const SizedBox(height: 20),
              const Text(
                'Amenities:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: amenities.entries
                    .map(
                      (entry) => FacilityChip(
                        title: entry.key,
                        value: entry.value,
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 20),
              const Text(
                'Uploaded Images:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              const RoomSubmissionImage(),
              const SizedBox(height: 20),
              Center(
                child: HotelButton(
                  text: "Submit",
                  onTap: () {
                    roomProvider.submitRoom().then((_) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const RoomListPage(),
                        ),
                      );
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $error')),
                      );
                    });
                  },
                  color: const Color(0xff1E91B6),
                  textColor: Colors.white,
                  borderRadius: 12.0,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  height: 50,
                  width: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
