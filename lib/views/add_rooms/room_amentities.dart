import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/field_information/roomprovider.dart';
import 'package:hotel_side/views/add_rooms/images_upload.dart';
import 'package:hotel_side/views/add_rooms/widgets/custom_card.dart';
import 'package:provider/provider.dart';

class RoomAmentities extends StatelessWidget {
  RoomAmentities({super.key});

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
                const SizedBox(
                  height: 10,
                ),

                // Laundry
                const SizedBox(
                  height: 10,
                ),
                CustomCardWithCheckbox(
                  title: 'Laundry', // Card name
                  icon: Icons.local_laundry_service, // Icon for the card
                  value: hotelProvider.roomData['Laundry'] ??
                      false, // Checkbox value
                  onChanged: (bool? value) {
                    hotelProvider.updateRoomData(
                        'Laundry', value ?? false); // Handle onChanged
                  },
                ),

                const SizedBox(
                  height: 10,
                ),
                CustomCardWithCheckbox(
                  title: 'Elevator', // Card name
                  icon: Icons.local_laundry_service, // Icon for the card
                  value: hotelProvider.roomData['Elevator'] ??
                      false, // Checkbox value
                  onChanged: (bool? value) {
                    hotelProvider.updateRoomData(
                        'Elevator', value ?? false); // Handle onChanged
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomCardWithCheckbox(
                  title: 'Air Conditioner', // Card name
                  icon: Icons.local_laundry_service, // Icon for the card
                  value: hotelProvider.roomData['Air Conditioner'] ??
                      false, // Checkbox value
                  onChanged: (bool? value) {
                    hotelProvider.updateRoomData(
                        'Air Conditioner', value ?? false); // Handle onChanged
                  },
                ),

                const SizedBox(
                  height: 10,
                ),
                CustomCardWithCheckbox(
                  title: 'House Keeping', // Card name
                  icon: Icons.local_laundry_service, // Icon for the card
                  value: hotelProvider.roomData['House Keeping'] ??
                      false, // Checkbox value
                  onChanged: (bool? value) {
                    hotelProvider.updateRoomData(
                        'House Keeping', value ?? false); // Handle onChanged
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomCardWithCheckbox(
                  title: 'Kitchen', // Card name
                  icon: Icons.local_laundry_service, // Icon for the card
                  value: hotelProvider.roomData['Kitchen'] ??
                      false, // Checkbox value
                  onChanged: (bool? value) {
                    hotelProvider.updateRoomData(
                        'Kitchen', value ?? false); // Handle onChanged
                  },
                ),

                const SizedBox(
                  height: 10,
                ),
                CustomCardWithCheckbox(
                  title: 'Wifi', // Card name
                  icon: Icons.local_laundry_service, // Icon for the card
                  value:
                      hotelProvider.roomData['Wifi'] ?? false, // Checkbox value
                  onChanged: (bool? value) {
                    hotelProvider.updateRoomData(
                        'Wifi', value ?? false); // Handle onChanged
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomCardWithCheckbox(
                  title: 'Parking', // Card name
                  icon: Icons.local_laundry_service, // Icon for the card
                  value: hotelProvider.roomData['Parking'] ??
                      false, // Checkbox value
                  onChanged: (bool? value) {
                    hotelProvider.updateRoomData(
                        'Parking', value ?? false); // Handle onChanged
                  },
                ),

                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Move to the image upload page
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const RoomImageUploadPage(),
                        ),
                      );
                    }
                  },
                  child: const Text('Next: Upload Images'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
   // Additional Features (WiFi, Breakfast, etc.)
              // SwitchListTile(
              //   title: const Text('WiFi Available'),
              //   value: hotelProvider.roomData['Wifi'] ?? false,
              //   onChanged: (value) {
              //     hotelProvider.updateRoomData('Wifi', value);
              //   },
              // ),

              // RoomRadioButton(
              //   heading: 'breakfast_included',
              //   groupValue:
              //       hotelProvider.roomData['breakfast_included'] ?? false,
              //   onChanged: (value) {
              //     hotelProvider.updateRoomData('breakfast_included', value);
              //   },
              //   textYes: 'yes',
              //   textNo: 'no',
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
              // Room Size
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
              // Base Price
              
                // Card(
                //   elevation: 4, // Adds shadow to the card
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(15), // Rounded corners
                //     side: BorderSide(
                //       color: Colors.tealAccent
                //           .shade400, // Add a border color for emphasis
                //       width: 2.0,
                //     ),
                //   ),
                //   color: const Color.fromARGB(229, 69, 232,
                //       213), // Use a more vibrant or gradient color
                //   child: Padding(
                //     padding: const EdgeInsets.all(
                //         8.0), // Add some padding inside the card
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         const Row(
                //           children: [
                //             Icon(
                //               Icons
                //                   .local_laundry_service, // Adding an icon to make it more engaging
                //               color: Colors.white,
                //             ),
                //             SizedBox(
                //                 width: 10), // Space between icon and text
                //             Text(
                //               'Laundry',
                //               style: TextStyle(
                //                 fontSize: 18,
                //                 fontWeight:
                //                     FontWeight.bold, // Bold text for emphasis
                //                 color: Colors
                //                     .white, // White text for better contrast
                //               ),
                //             ),
                //           ],
                //         ),
                //         Checkbox(
                //           value: hotelProvider.roomData['Laundry'] ?? false,
                //           onChanged: (bool? value) {
                //             hotelProvider.updateRoomData(
                //                 'Laundry', value ?? false);
                //           },
                //           activeColor: Colors
                //               .white, // White color for the active checkbox
                //           checkColor: Colors
                //               .tealAccent.shade400, // Custom checkmark color
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                       // Elevator
                // CheckboxListTile(
                //   title: const Text('Elevator'),
                //   value: hotelProvider.roomData['Elevator'] ?? false,
                //   onChanged: (bool? value) {
                //     hotelProvider.updateRoomData('Elevator', value ?? false);
                //   },
                //   controlAffinity: ListTileControlAffinity
                //       .trailing, // To place the checkbox on the leading edge
                // ),

                // Air Conditioner
                // const SizedBox(
                //   height: 10,
                // ),
                // CheckboxListTile(
                //   title: const Text('Air Conditioner'),
                //   value: hotelProvider.roomData['Air Conditioner'] ?? false,
                //   onChanged: (bool? value) {
                //     hotelProvider.updateRoomData(
                //         'Air Conditioner', value ?? false);
                //   },
                //   controlAffinity: ListTileControlAffinity
                //       .trailing, // To place the checkbox on the leading edge
                // ),
                               // House Keeping
                // const SizedBox(
                //   height: 10,
                // ),
                // CheckboxListTile(
                //   title: const Text('House Keeping'),
                //   value: hotelProvider.roomData['House Keeping'] ?? false,
                //   onChanged: (bool? value) {
                //     hotelProvider.updateRoomData(
                //         'House Keeping', value ?? false);
                //   },
                //   controlAffinity: ListTileControlAffinity
                //       .trailing, // To place the checkbox on the leading edge
                // ),

                // Kitchen
                             // const SizedBox(
                //   height: 10,
                // ),
                // CheckboxListTile(
                //   title: const Text('Kitchen'),
                //   value: hotelProvider.roomData['Kitchen'] ?? false,
                //   onChanged: (bool? value) {
                //     hotelProvider.updateRoomData('Kitchen', value ?? false);
                //   },
                //   controlAffinity: ListTileControlAffinity
                //       .trailing, // To place the checkbox on the leading edge
                // ),

                // Wifi
                             // const SizedBox(
                //   height: 10,
                // ),
                // CheckboxListTile(
                //   title: const Text('Wifi'),
                //   value: hotelProvider.roomData['Wifi'] ?? false,
                //   onChanged: (bool? value) {
                //     hotelProvider.updateRoomData('Wifi', value ?? false);
                //   },
                //   controlAffinity: ListTileControlAffinity
                //       .trailing, // To place the checkbox on the leading edge
                // ),
                        // const SizedBox(
                //   height: 10,
                // ),
                // CheckboxListTile(
                //   title: const Text('Parking'),
                //   value: hotelProvider.roomData['Parking'] ?? false,
                //   onChanged: (bool? value) {
                //     hotelProvider.updateRoomData('Parking', value ?? false);
                //   },
                //   controlAffinity: ListTileControlAffinity
                //       .trailing, // To place the checkbox on the leading edge
                // ),
                         // TextFormField(
                //   decoration:
                //       const InputDecoration(labelText: 'Base Price (₹)'),
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
                      // TextFormField(
                //   decoration: const InputDecoration(
                //       labelText: 'Number of Extra Child Allowed'),
                //   keyboardType: TextInputType.number,
                //   onChanged: (value) {
                //     hotelProvider.updateRoomData(
                //         'Number of Extra Child Allowed', int.tryParse(value));
                //   },
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter Number of Extra Child Allowed';
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
                  // CustomTextFormField(
                //   onChanged: (value) {
                //     hotelProvider.updateRoomData(
                //         'Base Price (₹)', int.tryParse(value));
                //   },
                //   labelText: 'Base Price (₹)',
                //   hintText: 'Base Price (₹)',
                //   keyboardType: TextInputType.visiblePassword,
                //   textInputAction: TextInputAction.done,
                //   autovalidateMode: AutovalidateMode.onUserInteraction,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Value is required';
                //     } else if (value.length < 4) {
                //       return 'Inavlid Value';
                //     }
                //     return null;
                //   },
                //   borderColor: Colors.grey,
                //   focusedBorderColor: Colors.blue,
                //   enabledBorderColor: Colors.grey,
                //   errorBorderColor: Colors.red,
                //   obscureText: true,
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                // CustomTextFormField(
                //   maxlength: 2,
                //   onChanged: (value) {
                //     hotelProvider.updateRoomData(
                //         'Number of Extra Adults Allowed', int.tryParse(value));
                //   },
                //   labelText: 'Number of Extra Adults Allowed',
                //   hintText: 'Number of Extra Adults Allowed',
                //   keyboardType: TextInputType.visiblePassword,
                //   textInputAction: TextInputAction.done,
                //   autovalidateMode: AutovalidateMode.onUserInteraction,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Value is required';
                //     } else if (value.length < 3) {
                //       return 'Inavlid Value';
                //     }
                //     return null;
                //   },
                //   borderColor: Colors.grey,
                //   focusedBorderColor: Colors.blue,
                //   enabledBorderColor: Colors.grey,
                //   errorBorderColor: Colors.red,
                //   obscureText: true,
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                // CustomTextFormField(
                //   maxlength: 2,
                //   onChanged: (value) {
                //     hotelProvider.updateRoomData(
                //         'Number of Extra Child Allowed', int.tryParse(value));
                //   },
                //   labelText: 'Number of Extra Child Allowed',
                //   hintText: 'Enter your Number of Extra Child Allowed',
                //   keyboardType: TextInputType.visiblePassword,
                //   textInputAction: TextInputAction.done,
                //   autovalidateMode: AutovalidateMode.onUserInteraction,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Value is required';
                //     } else if (value.length < 3) {
                //       return 'Inavlid Value';
                //     }
                //     return null;
                //   },
                //   borderColor: Colors.grey,
                //   focusedBorderColor: Colors.blue,
                //   enabledBorderColor: Colors.grey,
                //   errorBorderColor: Colors.red,
                //   obscureText: true,
                // ),
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
                // TextFormField(
                //   decoration: const InputDecoration(
                //       labelText: 'Number of Extra Child Allowed'),
                //   keyboardType: TextInputType.number,
                //   onChanged: (value) {
                //     hotelProvider.updateRoomData(
                //         'Number of Extra Child Allowed', int.tryParse(value));
                //   },
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter Number of Extra Child Allowed';
                //     }
                //     return null;
                //   },
                // ),
                // TextFormField(
                //   decoration: const InputDecoration(labelText: 'Base Price'),
                //   keyboardType: TextInputType.number,
                //   onChanged: (value) {
                //     hotelProvider.updateRoomData(
                //         'Base Price', int.tryParse(value));
                //   },
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Base Price';
                //     }
                //     return null;
                //   },
                // ),
