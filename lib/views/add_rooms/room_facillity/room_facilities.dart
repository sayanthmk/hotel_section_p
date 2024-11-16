import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/field_information/roomprovider.dart';
import 'package:hotel_side/views/add_rooms/room_amentites/room_amentities.dart';
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
                            .map<Widget>((item) => _FacilityCard(
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
                      Navigator.of(context).push(
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

class _FacilityCard extends StatelessWidget {
  static const primaryColor = Color(0xff1E91B6);
  final String title;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _FacilityCard({
    required this.title,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => onChanged(!value),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: value
                        ? primaryColor.withOpacity(0.1)
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: value ? primaryColor : Colors.grey[600],
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: value ? FontWeight.w600 : FontWeight.normal,
                      color: value ? primaryColor : const Color(0xFF2C3E50),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _RadioOption(
                      label: 'No',
                      isSelected: !value,
                      onTap: () => onChanged(false),
                    ),
                    const SizedBox(width: 8),
                    _RadioOption(
                      label: 'Yes',
                      isSelected: value,
                      onTap: () => onChanged(true),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RadioOption extends StatelessWidget {
  static const primaryColor = Color(0xff1E91B6);
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _RadioOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey[300]!,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
        // CustomSquareCheckboxGroup(
              //   // value: hotelProvider.roomData['breakfast_included'] ?? false,
              //   onChanged: (value) {
              //     hotelProvider.updateRoomData('Free Breakfast', value);
              //   },
              //   size: 30.0, // Customize size
              //   activeColor: Colors.green, // Customize active color
              //   checkColor: Colors.white, isTrueSelected: false, textTrue: '',
              //   textFalse: '', // Customize checkmark color
              // ),
              // const SizedBox(width: 10),
              // const Text('Free Breakfast'),
              // Submit Button
                 // RadioListTile<bool>(
              //   title: const Text('WiFi Available'),
              //   value:
              //       true, // This radio button represents the option for WiFi available (true)
              //   groupValue: hotelProvider.roomData['wifi_available'] ??
              //       false, // Current value from provider
              //   onChanged: (value) {
              //     hotelProvider.updateRoomData('wifi_available',
              //         value); // Update provider with selected value
              //   },
              // ),
              // CustomCheckbox(
              //   value: true,
              //   onChanged: (bool? value) {
              //     hotelProvider.updateRoomData('wifi_available', value);
              //   },
              // ),
                  // SwitchListTile(
              //   title: const Text('Breakfast Included'),
              //   value: hotelProvider.roomData['breakfast_included'] ?? false,
              //   onChanged: (value) {
              //     hotelProvider.updateRoomData('breakfast_included', value);
              //   },
              // ),
                // Base Price
              // TextFormField(
              //   decoration: const InputDecoration(labelText: 'Base Price (₹)'),
              //   keyboardType: TextInputType.number,
              //   onChanged: (value) {
              //     hotelProvider.updateRoomData(
              //         'Base Price', int.tryParse(value));
              //   },
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter the base price';
              //     }
              //     return null;
              //   },
              // ),
              // Max Occupants
              // TextFormField(
              //   decoration: const InputDecoration(
              //       labelText: 'Number of Extra Adults Allowed'),
              //   keyboardType: TextInputType.number,
              //   onChanged: (value) {
              //     hotelProvider.updateRoomData(
              //         'Number of Extra Adults Allowed', int.tryParse(value));
              //   },
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter Number of Extra Adults Allowed';
              //     }
              //     return null;
              //   },
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Additional Features (WiFi, Breakfast, etc.)
              // SwitchListTile(
              //   title: const Text('WiFi Available'),
              //   value: hotelProvider.roomData['Wifi'] ?? false,
              //   onChanged: (value) {
              //     hotelProvider.updateRoomData('Wifi', value);
              //   },
              // ),
                     // Room Type
                // TextFormField(
                //   decoration: const InputDecoration(labelText: 'Room Area'),
                //   onChanged: (value) {
                //     hotelProvider.updateRoomData('room_area', value);
                //   },
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter the room area';
                //     }
                //     return null;
                //   },
                // ),
                // // Room Size
                // TextFormField(
                //   decoration:
                //       const InputDecoration(labelText: 'Room Size (sq. ft)'),
                //   keyboardType: TextInputType.number,
                //   onChanged: (value) {
                //     hotelProvider.updateRoomData(
                //         'Property Size', int.tryParse(value));
                //   },
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter the room size';
                //     }
                //     return null;
                //   },
                // ),
