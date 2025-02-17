import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/room_controller/roomprovider.dart';
import 'package:hotel_side/views/add_rooms/room_amentites/room_amentities.dart';
import 'package:hotel_side/views/add_rooms/room_facillity/room_facility_card.dart';
import 'package:provider/provider.dart';

class RoomFacility extends StatelessWidget {
  RoomFacility({super.key});

  final _formKey = GlobalKey<FormState>();

  static const primaryColor = Color(0xff1E91B6);

  final List<Map<String, dynamic>> facilitiesGroups = [
    {
      'title': 'Storage',
      'items': [
        {'name': 'Cupboard', 'icon': Icons.weekend},
        {'name': 'Wardrobe', 'icon': Icons.door_sliding},
      ]
    },
    {
      'title': 'Meal Plans',
      'items': [
        {'name': 'Accommodation Only', 'icon': Icons.hotel},
        {'name': 'Free Breakfast', 'icon': Icons.free_breakfast},
        {'name': 'Free Lunch', 'icon': Icons.lunch_dining},
        {'name': 'Free Dinner', 'icon': Icons.dinner_dining},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<RoomProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Room Facilities',
          style: TextStyle(
            color: Color(0xFF2C3E50),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2C3E50)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: facilitiesGroups.length,
                  itemBuilder: (context, groupIndex) {
                    final group = facilitiesGroups[groupIndex];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            group['title'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF95A5A6),
                            ),
                          ),
                        ),
                        ...group['items']
                            .map<Widget>((item) => RoomFacilityCard(
                                  title: item['name'],
                                  icon: item['icon'],
                                  value: hotelProvider.roomData[item['name']] ??
                                      false,
                                  onChanged: (value) {
                                    hotelProvider.updateRoomData(
                                        item['name'], value);
                                  },
                                ))
                            .toList(),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => RoomAmenities(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Continue to Amenities',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
