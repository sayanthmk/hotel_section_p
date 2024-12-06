// // ignore_for_file: use_build_context_synchronously
// import 'package:flutter/material.dart';
// import 'package:hotel_side/controllers/room_controller/roomprovider.dart';
// import 'package:hotel_side/widgets/auth_widgets/textfrom_field.dart';
// import 'package:hotel_side/widgets/home_page_widgets/button.dart';
// import 'package:provider/provider.dart';

// class RoomEditingPage extends StatelessWidget {
//   RoomEditingPage({super.key});
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     final roomProvider = Provider.of<RoomProvider>(context, listen: true);
//     return Consumer<RoomProvider>(builder: (context, provider, child) {
//       final roomDetails = provider.selectedRoom!;

//       // Text Controllers
//       final TextEditingController roomAreaController = TextEditingController(
//           text: roomDetails['room_area']?.toString() ?? '');
//       final TextEditingController roomTypeController =
//           TextEditingController(text: roomDetails['room_type'] ?? '');
//       final TextEditingController propertySizeController =
//           TextEditingController(
//               text: roomDetails['Property Size']?.toString() ?? '0');
//       final TextEditingController extraBedTypesController =
//           TextEditingController(
//               text: roomDetails['Select Extra Bed Types']?.toString() ?? '0');
//       final TextEditingController basePriceController = TextEditingController(
//           text: roomDetails['Base Price']?.toString() ?? '0');
//       final TextEditingController extraAdultsController = TextEditingController(
//           text:
//               roomDetails['Number of Extra Adults Allowed']?.toString() ?? '0');
//       final TextEditingController extraChildController = TextEditingController(
//           text:
//               roomDetails['Number of Extra Child Allowed']?.toString() ?? '0');

//       return Scaffold(
//         appBar: AppBar(
//           title: const Text('Edit Room Details'),
//           backgroundColor: const Color(0xFF1E91B6),
//           foregroundColor: Colors.white,
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Basic Information',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 16),
//                 CustomTextFormField(
//                   controller: roomAreaController,
//                   labelText: 'Room Area',
//                   validator: (value) =>
//                       value?.isEmpty ?? true ? 'Required field' : null,
//                 ),
//                 const SizedBox(height: 12),
//                 CustomTextFormField(
//                   controller: roomTypeController,
//                   labelText: 'Room Type',
//                   validator: (value) =>
//                       value?.isEmpty ?? true ? 'Required field' : null,
//                 ),
//                 const SizedBox(height: 12),
//                 CustomTextFormField(
//                   controller: propertySizeController,
//                   labelText: 'Property Size',
//                   keyboardType: TextInputType.number,
//                   validator: (value) =>
//                       value?.isEmpty ?? true ? 'Required field' : null,
//                 ),
//                 const SizedBox(height: 24),
//                 const Text(
//                   'Capacity & Pricing',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 16),
//                 CustomTextFormField(
//                   controller: extraBedTypesController,
//                   labelText: 'Extra Bed Types',
//                   keyboardType: TextInputType.number,
//                   validator: (value) =>
//                       value?.isEmpty ?? true ? 'Required field' : null,
//                 ),
//                 const SizedBox(height: 12),
//                 CustomTextFormField(
//                   controller: basePriceController,
//                   labelText: 'Base Price',
//                   keyboardType: TextInputType.number,
//                   validator: (value) =>
//                       value?.isEmpty ?? true ? 'Required field' : null,
//                 ),
//                 const SizedBox(height: 12),
//                 CustomTextFormField(
//                   controller: extraAdultsController,
//                   labelText: 'Extra Adults Allowed',
//                   keyboardType: TextInputType.number,
//                   validator: (value) =>
//                       value?.isEmpty ?? true ? 'Required field' : null,
//                 ),
//                 const SizedBox(height: 12),
//                 CustomTextFormField(
//                   controller: extraChildController,
//                   labelText: 'Extra Children Allowed',
//                   keyboardType: TextInputType.number,
//                   validator: (value) =>
//                       value?.isEmpty ?? true ? 'Required field' : null,
//                 ),
//                 const SizedBox(height: 24),
//                 const Text(
//                   'Amenities',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 16),
//                 _buildSwitchTile(
//                     context,
//                     'Cupboard',
//                     roomDetails['Cupboard'] ?? false,
//                     (value) => roomDetails['Cupboard'] = value),
//                 _buildSwitchTile(
//                     context,
//                     'Wardrobe',
//                     roomDetails['Wardrobe'] ?? false,
//                     (value) => roomDetails['Wardrobe'] = value),
//                 _buildSwitchTile(
//                     context,
//                     'Free Breakfast',
//                     roomDetails['Free Breakfast'] ?? false,
//                     (value) => roomDetails['Free Breakfast'] = value),
//                 _buildSwitchTile(
//                     context,
//                     'Free Lunch',
//                     roomDetails['Free Lunch'] ?? false,
//                     (value) => roomDetails['Free Lunch'] = value),
//                 _buildSwitchTile(
//                     context,
//                     'Free Dinner',
//                     roomDetails['Free Dinner'] ?? false,
//                     (value) => roomDetails['Free Dinner'] = value),
//                 _buildSwitchTile(
//                     context,
//                     'Laundry',
//                     roomDetails['Laundry'] ?? false,
//                     (value) => roomDetails['Laundry'] = value),
//                 _buildSwitchTile(
//                     context,
//                     'Elevator',
//                     roomDetails['Elevator'] ?? false,
//                     (value) => roomDetails['Elevator'] = value),
//                 _buildSwitchTile(
//                     context,
//                     'Air Conditioner',
//                     roomDetails['Air Conditioner'] ?? false,
//                     (value) => roomDetails['Air Conditioner'] = value),
//                 _buildSwitchTile(
//                     context,
//                     'House Keeping',
//                     roomDetails['House Keeping'] ?? false,
//                     (value) => roomDetails['House Keeping'] = value),
//                 _buildSwitchTile(
//                     context,
//                     'Kitchen',
//                     roomDetails['Kitchen'] ?? false,
//                     (value) => roomDetails['Kitchen'] = value),
//                 _buildSwitchTile(context, 'Wifi', roomDetails['Wifi'] ?? false,
//                     (value) => roomDetails['Wifi'] = value),
//                 _buildSwitchTile(
//                     context,
//                     'Parking',
//                     roomDetails['Parking'] ?? false,
//                     (value) => roomDetails['Parking'] = value),
//                 const SizedBox(height: 24),
//                 Center(
//                   child: HotelButton(
//                     text: "Update Room",
//                     onTap: () async {
//                       if (_formKey.currentState!.validate()) {
//                         try {
//                           Map<String, dynamic> updatedData = {
//                             'room_area': roomAreaController.text,
//                             'room_type': roomTypeController.text,
//                             'Property Size':
//                                 int.parse(propertySizeController.text),
//                             'Select Extra Bed Types':
//                                 int.parse(extraBedTypesController.text),
//                             'Base Price': int.parse(basePriceController.text),
//                             'Number of Extra Adults Allowed':
//                                 int.parse(extraAdultsController.text),
//                             'Number of Extra Child Allowed':
//                                 int.parse(extraChildController.text),
//                             'Cupboard': roomDetails['Cupboard'],
//                             'Wardrobe': roomDetails['Wardrobe'],
//                             'Free Breakfast': roomDetails['Free Breakfast'],
//                             'Free Lunch': roomDetails['Free Lunch'],
//                             'Free Dinner': roomDetails['Free Dinner'],
//                             'Laundry': roomDetails['Laundry'],
//                             'Elevator': roomDetails['Elevator'],
//                             'Air Conditioner': roomDetails['Air Conditioner'],
//                             'House Keeping': roomDetails['House Keeping'],
//                             'Kitchen': roomDetails['Kitchen'],
//                             'Wifi': roomDetails['Wifi'],
//                             'Parking': roomDetails['Parking'],
//                             'room_images': roomDetails['room_images'],
//                           };

//                           await roomProvider.updateRoom(
//                             roomDetails['room_id'],
//                             updatedData,
//                           );

//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content:
//                                   Text('Room details updated successfully!'),
//                               backgroundColor: Colors.green,
//                             ),
//                           );
//                           Navigator.pop(context);
//                         } catch (e) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text(
//                                   'Failed to update room: ${e.toString()}'),
//                               backgroundColor: Colors.red,
//                             ),
//                           );
//                         }
//                       }
//                     },
//                     color: const Color(0xff1E91B6),
//                     textColor: Colors.white,
//                     borderRadius: 15.0,
//                     padding: const EdgeInsets.symmetric(vertical: 15.0),
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.w600,
//                     height: 55,
//                     width: 200,
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }

//   Widget _buildSwitchTile(
//     BuildContext context,
//     String title,
//     bool value,
//     Function(bool) onChanged,
//   ) {
//     return SwitchListTile(
//       title: Text(title),
//       value: value,
//       onChanged: onChanged,
//       activeColor: const Color(0xFF1E91B6),
//     );
//   }
// }

