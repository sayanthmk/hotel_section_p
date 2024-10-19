// import 'package:flutter/material.dart';
// import 'package:hotel_side/controllers/field_information/datas_page.dart';
// import 'package:provider/provider.dart';

// class SecondPage extends StatelessWidget {
//   final TextEditingController hotelNameController = TextEditingController();
//   final TextEditingController bookingSinceController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();

//   SecondPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final hotelProvider = Provider.of<HotelProvider>(context, listen: false);

//     return Scaffold(
//       appBar: AppBar(title: const Text('Hotel Information')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: <Widget>[
//               // Hotel Name Field
//               TextFormField(
//                 controller: hotelNameController,
//                 decoration: const InputDecoration(labelText: 'Hotel Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter hotel name';
//                   }
//                   return null;
//                 },
//               ),

//               // Booking Since Field
//               TextFormField(
//                 controller: bookingSinceController,
//                 decoration:
//                     const InputDecoration(labelText: 'Booking Since (Year)'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the booking year';
//                   }
//                   return null;
//                 },
//               ),

//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     // Update the provider with values from the controllers
//                     hotelProvider.updateHotelData(
//                         'hotel_name', hotelNameController.text);
//                     hotelProvider.updateHotelData('Booking_since',
//                         int.parse(bookingSinceController.text));

//                     // Navigate to the next page
//                     Navigator.pushNamed(context, '/thirdPage');
//                   }
//                 },
//                 child: const Text('Next'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
