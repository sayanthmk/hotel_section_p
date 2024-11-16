import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/field_information/roomprovider.dart';
import 'package:hotel_side/views/add_rooms/images_upload.dart';
import 'package:hotel_side/views/add_rooms/room_amentites/widgets/amentity_card.dart';
import 'package:provider/provider.dart';

class RoomAmenities extends StatelessWidget {
  RoomAmenities({super.key});

  final _formKey = GlobalKey<FormState>();

  // Define custom colors
  static const primaryColor = Color(0xff1E91B6);
  static final secondaryColor = primaryColor.withOpacity(0.1);
  static const textDarkColor = Color(0xFF2C3E50);
  static const textLightColor = Color(0xFF95A5A6);

  final List<Map<String, dynamic>> amenitiesGroups = [
    {
      'title': 'Basic Amenities',
      'items': [
        {'name': 'Wifi', 'icon': Icons.wifi},
        {'name': 'Air Conditioner', 'icon': Icons.ac_unit},
        {'name': 'House Keeping', 'icon': Icons.cleaning_services},
      ]
    },
    {
      'title': 'Additional Features',
      'items': [
        {'name': 'Kitchen', 'icon': Icons.kitchen},
        {'name': 'Laundry', 'icon': Icons.local_laundry_service},
        {'name': 'Parking', 'icon': Icons.local_parking},
      ]
    },
    {
      'title': 'Building Features',
      'items': [
        {'name': 'Elevator', 'icon': Icons.elevator},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<RoomProvider>(context, listen: true);

    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: primaryColor,
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.selected)) {
              return primaryColor;
            }
            return Colors.white;
          }),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'Room Amenities',
            style: TextStyle(
              color: textDarkColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: textDarkColor),
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
                    itemCount: amenitiesGroups.length,
                    itemBuilder: (context, groupIndex) {
                      final group = amenitiesGroups[groupIndex];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              group['title'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: textLightColor,
                              ),
                            ),
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            itemCount: group['items'].length,
                            itemBuilder: (context, index) {
                              final amenity = group['items'][index];
                              return AmenityCard(
                                title: amenity['name'],
                                icon: amenity['icon'],
                                value:
                                    hotelProvider.roomData[amenity['name']] ??
                                        false,
                                onChanged: (value) {
                                  hotelProvider.updateRoomData(
                                      amenity['name'], value ?? false);
                                },
                                primaryColor: primaryColor,
                                secondaryColor: secondaryColor,
                              );
                            },
                          ),
                          const SizedBox(height: 24),
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const RoomImageUploadPage(),
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
                          'Continue to Image Upload',
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
      ),
    );
  }
}


  