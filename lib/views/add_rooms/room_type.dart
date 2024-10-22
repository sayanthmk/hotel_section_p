import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/field_information/roomprovider.dart';
import 'package:hotel_side/views/add_rooms/room_facilities.dart';
import 'package:hotel_side/widgets/home_page_widgets/custom_dropdown.dart';
import 'package:provider/provider.dart';

class RoomTypeSelection extends StatelessWidget {
  RoomTypeSelection({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context, listen: true);

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
                CustomDropdown(
                  hintText: 'Select room type',
                  value: roomProvider.roomsSelectedItem,
                  items: roomProvider.roomsItems,
                  onChanged: (String? newValue) {
                    roomProvider.setRoomSelectedItem(newValue);
                    roomProvider.updateRoomData('room_type', newValue);
                  },
                ),
                // Room Type
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Room Area'),
                  onChanged: (value) {
                    roomProvider.updateRoomData('room_area', value);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the room area';
                    }
                    return null;
                  },
                ),
                // Room Size
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Room Size (sq. ft)'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    roomProvider.updateRoomData(
                        'Property Size', int.tryParse(value));
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the room size';
                    }
                    return null;
                  },
                ),

                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Number of Extra Adults Allowed'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    roomProvider.updateRoomData(
                        'Number of Extra Adults Allowed', int.tryParse(value));
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Number of Extra Adults Allowed';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Number of Extra Child Allowed'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    roomProvider.updateRoomData(
                        'Number of Extra Child Allowed', int.tryParse(value));
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Number of Extra Child Allowed';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Base Price'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    roomProvider.updateRoomData(
                        'Base Price', int.tryParse(value));
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Base Price';
                    }
                    return null;
                  },
                ),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Move to the image upload page
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => RoomFacility(),
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
