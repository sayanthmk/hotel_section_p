import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_side/controllers/field_information/hotel_provider.dart';
import 'package:hotel_side/views/registration_page/location/current_location.dart';
import 'package:hotel_side/views/registration_page/location/loction_fields.dart';
import 'package:hotel_side/views/registration_page/poilcy_page/policies.dart';
import 'package:hotel_side/widgets/home_page_widgets/button.dart';
import 'package:hotel_side/widgets/home_page_widgets/search_bar.dart';
import 'package:provider/provider.dart';

class LocationAddByUser extends StatelessWidget {
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LocationAddByUser({super.key});

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<HotelProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffF5F9FF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Hotel Location Details',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3142),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF2D3142)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Search Bar with enhanced styling
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 10,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: const CustomSearchBar(
                            hintText: 'Search location',
                            borderColor: Colors.transparent,
                            hintTextColor: Colors.grey,
                            textColor: Colors.black,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 25),

                        // Current Location Button
                        CurrentLocationSection()
                        // Container(
                        //   padding: const EdgeInsets.all(15),
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(12),
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Colors.grey.withOpacity(0.1),
                        //         spreadRadius: 1,
                        //         blurRadius: 10,
                        //         offset: const Offset(0, 1),
                        //       ),
                        //     ],
                        //   ),
                        //   child: const Row(
                        //     children: [
                        //       Icon(
                        //         FontAwesomeIcons.locationCrosshairs,
                        //         color: Color(0xff1E91B6),
                        //         size: 20,
                        //       ),
                        //       SizedBox(width: 12),
                        //       Text(
                        //         'Use Current Location',
                        //         style: TextStyle(
                        //           fontSize: 16,
                        //           fontWeight: FontWeight.w500,
                        //           color: Color(0xFF2D3142),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        ,
                        SizedBox(height: 25),

                        // Information Text
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: const Color(0xff1E91B6).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Please provide accurate location details to help guests find your property easily.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff1E91B6),
                              height: 1.5,
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Form Fields Section
                        LocationField(
                            cityController: cityController,
                            stateController: stateController,
                            countryController: countryController,
                            pincodeController: pincodeController),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Bottom Button
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              child: HotelButton(
                text: "Continue",
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    hotelProvider.updateHotelData('city', cityController.text);
                    hotelProvider.updateHotelData(
                        'state', stateController.text);
                    hotelProvider.updateHotelData(
                        'country', countryController.text);
                    hotelProvider.updateHotelData(
                        'pincode', int.parse(pincodeController.text));
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const PoliciesPage()),
                    );
                  }
                },
                color: const Color(0xff1E91B6),
                textColor: Colors.white,
                borderRadius: 15.0,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                height: 55,
                width: size.width - 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:hotel_side/controllers/field_information/hotel_provider.dart';
// import 'package:hotel_side/views/registration_page/poilcy_page/policies.dart';
// import 'package:hotel_side/widgets/auth_widgets/textfrom_field.dart';
// import 'package:hotel_side/widgets/home_page_widgets/button.dart';
// import 'package:hotel_side/widgets/home_page_widgets/search_bar.dart';
// import 'package:provider/provider.dart';

// class LocationAddByUser extends StatelessWidget {
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController stateController = TextEditingController();
//   final TextEditingController countryController = TextEditingController();
//   final TextEditingController pincodeController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();

//   LocationAddByUser({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final hotelProvider = Provider.of<HotelProvider>(context, listen: false);

//     return Scaffold(
//       backgroundColor: const Color(0xffF5F9FF),
//       appBar: AppBar(
//         title: const Text('Hotel Location Details'),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       children: [
//                         const CustomSearchBar(
//                           hintText: '',
//                           borderColor: Colors.grey,
//                           hintTextColor: Colors.grey,
//                           textColor: Colors.grey,
//                           backgroundColor: Colors.white,
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         const Row(
//                           children: [
//                             Icon(FontAwesomeIcons.locationCrosshairs),
//                             Text('Use Current Location')
//                           ],
//                         ),
//                         const Divider(),
//                         const Text(
//                             textAlign: TextAlign.start,
//                             'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.'),
//                         const Divider(),
//                         const SizedBox(
//                           height: 40,
//                         ),
//                         CustomTextFormField(
//                           controller: cityController,
//                           labelText: 'City',
//                           hintText: 'Enter your City',
//                           textInputAction: TextInputAction.done,
//                           autovalidateMode: AutovalidateMode.onUserInteraction,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'City is required';
//                             }
//                             return null;
//                           },
//                           borderColor: Colors.grey,
//                           focusedBorderColor: Colors.blue,
//                           enabledBorderColor: Colors.grey,
//                           errorBorderColor: Colors.red,
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         CustomTextFormField(
//                           controller: stateController,
//                           labelText: 'State',
//                           hintText: 'Enter your State',
//                           textInputAction: TextInputAction.done,
//                           autovalidateMode: AutovalidateMode.onUserInteraction,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'State is required';
//                             }
//                             return null;
//                           },
//                           borderColor: Colors.grey,
//                           focusedBorderColor: Colors.blue,
//                           enabledBorderColor: Colors.grey,
//                           errorBorderColor: Colors.red,
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         CustomTextFormField(
//                           height: 80,
//                           controller: countryController,
//                           labelText: 'Country',
//                           hintText: 'Enter your Country',
//                           textInputAction: TextInputAction.done,
//                           autovalidateMode: AutovalidateMode.onUserInteraction,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Country is required';
//                             }
//                             return null;
//                           },
//                           borderColor: Colors.grey,
//                           focusedBorderColor: Colors.blue,
//                           enabledBorderColor: Colors.grey,
//                           errorBorderColor: Colors.red,
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         CustomTextFormField(
//                           controller: pincodeController,
//                           labelText: 'Pincode',
//                           hintText: 'Enter your Pincode',
//                           textInputAction: TextInputAction.done,
//                           autovalidateMode: AutovalidateMode.onUserInteraction,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Pincode is required';
//                             } else if (value.length < 6) {
//                               return 'Invalid Pincode';
//                             }
//                             return null;
//                           },
//                           borderColor: Colors.grey,
//                           focusedBorderColor: Colors.blue,
//                           enabledBorderColor: Colors.grey,
//                           errorBorderColor: Colors.red,
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: HotelButton(
//                             text: "Next",
//                             onTap: () {
//                               if (_formKey.currentState!.validate()) {
//                                 hotelProvider.updateHotelData(
//                                     'city', cityController.text);
//                                 hotelProvider.updateHotelData(
//                                     'state', stateController.text);
//                                 hotelProvider.updateHotelData(
//                                     'country', countryController.text);

//                                 hotelProvider.updateHotelData('pincode',
//                                     int.parse(pincodeController.text));

//                                 Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (context) => const PoliciesPage(),
//                                 ));
//                               }
//                             },
//                             color: const Color(0xff1E91B6),
//                             textColor: Colors.white,
//                             borderRadius: 10.0,
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 15.0, horizontal: 30.0),
//                             fontSize: 16.0,
//                             fontWeight: FontWeight.bold,
//                             height: 50,
//                             width: 300,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// //       // Padding(
// //             //   padding: const EdgeInsets.all(16.0),
// //             //   child: HotelButton(
// //             //     text: "Next",
// //             //     onTap: () {
// //             //       if (_formKey.currentState!.validate()) {
// //             //         // Update provider with location data

// //             //         hotelProvider.updateHotelData('city', cityController.text);
// //             //         hotelProvider.updateHotelData(
// //             //             'state', stateController.text);
// //             //         hotelProvider.updateHotelData(
// //             //             'country', countryController.text);

// //             //         hotelProvider.updateHotelData(
// //             //             'pincode', int.parse(pincodeController.text));

// //             //         Navigator.of(context).push(MaterialPageRoute(
// //             //           builder: (context) => PoliciesPage(),
// //             //         ));
// //             //       }
// //             //     },
// //             //     color: const Color(0xff1E91B6),
// //             //     textColor: Colors.white,
// //             //     borderRadius: 10.0,
// //             //     padding: const EdgeInsets.symmetric(
// //             //         vertical: 15.0, horizontal: 30.0),
// //             //     fontSize: 16.0,
// //             //     fontWeight: FontWeight.bold,
// //             //     height: 50,
// //             //     width: 300,
// //             //   ),
// //             // ),
