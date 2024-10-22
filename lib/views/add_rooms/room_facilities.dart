import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/field_information/roomprovider.dart';
import 'package:hotel_side/views/add_rooms/room_amentities.dart';
import 'package:hotel_side/widgets/rooms_widgets/squre_radio_button.dart';
import 'package:provider/provider.dart';

class RoomFacility extends StatelessWidget {
  RoomFacility({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<RoomProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Room Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Cupboard
                RoomRadioButton(
                  heading: 'Cupboard',
                  groupValue: hotelProvider.roomData['Cupboard'] ?? false,
                  onChanged: (value) {
                    hotelProvider.updateRoomData('Cupboard', value);
                  },
                  textYes: 'yes',
                  textNo: 'no',
                ),
                //Wardrobe
                RoomRadioButton(
                  heading: 'Wardrobe',
                  groupValue: hotelProvider.roomData['Wardrobe'] ?? false,
                  onChanged: (value) {
                    hotelProvider.updateRoomData('Wardrobe', value);
                  },
                  textYes: 'yes',
                  textNo: 'no',
                ),
                // Accommodation Only
                RoomRadioButton(
                  heading: 'Accommodation Only',
                  groupValue:
                      hotelProvider.roomData['Accommodation Only'] ?? false,
                  onChanged: (value) {
                    hotelProvider.updateRoomData('Accommodation Only', value);
                  },
                  textYes: 'yes',
                  textNo: 'no',
                ),
                // Free Breakfast
                RoomRadioButton(
                  heading: 'Free Breakfast',
                  groupValue: hotelProvider.roomData['Free Breakfast'] ?? false,
                  onChanged: (value) {
                    hotelProvider.updateRoomData('Free Breakfast', value);
                  },
                  textYes: 'yes',
                  textNo: 'no',
                ),
                // Free Lunch
                RoomRadioButton(
                  heading: 'Free Lunch',
                  groupValue: hotelProvider.roomData['Free Lunch'] ?? false,
                  onChanged: (value) {
                    hotelProvider.updateRoomData('Free Lunch', value);
                  },
                  textYes: 'yes',
                  textNo: 'no',
                ),
                // Free Dinner
                RoomRadioButton(
                  heading: 'Free Dinner',
                  groupValue: hotelProvider.roomData['Free Dinner'] ?? false,
                  onChanged: (value) {
                    hotelProvider.updateRoomData('Free Dinner', value);
                  },
                  textYes: 'yes',
                  textNo: 'no',
                ),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Move to the image upload page
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => RoomAmentities(),
                        ),
                      );
                    }
                  },
                  child: const Text('Next'),
                ),
              ],
            ),
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
