import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/room_controller/roomprovider.dart';
import 'package:hotel_side/views/add_rooms/room_facillity/room_facilities.dart';
import 'package:hotel_side/views/add_rooms/room_type/room_textform.dart';
import 'package:hotel_side/widgets/home_page_widgets/custom_dropdown.dart';
import 'package:provider/provider.dart';
import 'room_type_widgets.dart';

class RoomTypeSelection extends StatelessWidget {
  RoomTypeSelection({super.key});

  final _formKey = GlobalKey<FormState>();
  final Color primaryBlue = const Color(0xff1E91B6);
  final Color textColor = const Color(0xFF2D3142);

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryBlue,
        title: const Text(
          'Add Room Details',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryBlue.withOpacity(0.05),
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomSection(
                    title: 'Basic Information',
                    textColor: textColor,
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
                      const SizedBox(height: 20),
                      RoomCustomFormField(
                        label: 'Room Area',
                        hint: 'Enter room area',
                        onChanged: (value) {
                          roomProvider.updateRoomData('room_area', value);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Room area is required';
                          }
                          return null;
                        },
                        prefixIcon: Icons.square_foot,
                        primaryColor: primaryBlue,
                        textColor: textColor,
                      ),
                      const SizedBox(height: 20),
                      RoomCustomFormField(
                        label: 'Room Size',
                        hint: 'Enter room size in sq. ft',
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          roomProvider.updateRoomData(
                              'Property Size', int.tryParse(value));
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Room size is required';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                        prefixIcon: Icons.architecture,
                        primaryColor: primaryBlue,
                        textColor: textColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomSection(
                    title: 'Capacity & Pricing',
                    textColor: textColor,
                    children: [
                      RoomCustomFormField(
                        label: 'Extra Adults',
                        hint: 'Enter number of extra adults allowed',
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          roomProvider.updateRoomData(
                            'Number of Extra Adults Allowed',
                            int.tryParse(value),
                          );
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Extra adults count is required';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                        prefixIcon: Icons.person_add,
                        primaryColor: primaryBlue,
                        textColor: textColor,
                      ),
                      const SizedBox(height: 20),
                      RoomCustomFormField(
                        label: 'Extra Children',
                        hint: 'Enter number of extra children allowed',
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          roomProvider.updateRoomData(
                            'Number of Extra Child Allowed',
                            int.tryParse(value),
                          );
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Extra children count is required';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                        prefixIcon: Icons.child_care,
                        primaryColor: primaryBlue,
                        textColor: textColor,
                      ),
                      const SizedBox(height: 20),
                      RoomCustomFormField(
                        label: 'Base Price',
                        hint: 'Enter base price',
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          roomProvider.updateRoomData(
                              'Base Price', int.tryParse(value));
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Base price is required';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                        prefixIcon: Icons.attach_money,
                        primaryColor: primaryBlue,
                        textColor: textColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  CustomContinueButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => RoomFacility()),
                        );
                      }
                    },
                    text: 'Continue to Facilities',
                    primaryColor: primaryBlue,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
