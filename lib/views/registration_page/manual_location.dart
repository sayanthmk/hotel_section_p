//================check

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_side/controllers/field_information/datas_page.dart';
import 'package:hotel_side/controllers/field_information/hotel_provider.dart';
import 'package:hotel_side/views/registration_page/policies.dart';
import 'package:hotel_side/widgets/auth_widgets/textfrom_field.dart';
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

    return Scaffold(
      backgroundColor: const Color(0xffF5F9FF),
      appBar: AppBar(
        title: const Text('Hotel Location Details'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const CustomSearchBar(
                          hintText: '',
                          borderColor: Colors.grey,
                          hintTextColor: Colors.grey,
                          textColor: Colors.grey,
                          backgroundColor: Colors.white,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          children: [
                            Icon(FontAwesomeIcons.locationCrosshairs),
                            Text('Use Current Location')
                          ],
                        ),
                        const Divider(),
                        const Text(
                            textAlign: TextAlign.start,
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.'),
                        const Divider(),
                        const SizedBox(
                          height: 40,
                        ),
                        CustomTextFormField(
                          controller: cityController,
                          labelText: 'City',
                          hintText: 'Enter your City',
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'City is required';
                            }
                            return null;
                          },
                          borderColor: Colors.grey,
                          focusedBorderColor: Colors.blue,
                          enabledBorderColor: Colors.grey,
                          errorBorderColor: Colors.red,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          controller: stateController,
                          labelText: 'State',
                          hintText: 'Enter your State',
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'State is required';
                            }
                            return null;
                          },
                          borderColor: Colors.grey,
                          focusedBorderColor: Colors.blue,
                          enabledBorderColor: Colors.grey,
                          errorBorderColor: Colors.red,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          height: 80,
                          controller: countryController,
                          labelText: 'Country',
                          hintText: 'Enter your Country',
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Country is required';
                            }
                            return null;
                          },
                          borderColor: Colors.grey,
                          focusedBorderColor: Colors.blue,
                          enabledBorderColor: Colors.grey,
                          errorBorderColor: Colors.red,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          controller: pincodeController,
                          labelText: 'Pincode',
                          hintText: 'Enter your Pincode',
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Pincode is required';
                            } else if (value.length < 6) {
                              return 'Invalid Pincode';
                            }
                            return null;
                          },
                          borderColor: Colors.grey,
                          focusedBorderColor: Colors.blue,
                          enabledBorderColor: Colors.grey,
                          errorBorderColor: Colors.red,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: HotelButton(
                            text: "Next",
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                hotelProvider.updateHotelData(
                                    'city', cityController.text);
                                hotelProvider.updateHotelData(
                                    'state', stateController.text);
                                hotelProvider.updateHotelData(
                                    'country', countryController.text);

                                hotelProvider.updateHotelData('pincode',
                                    int.parse(pincodeController.text));

                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const PoliciesPage(),
                                ));
                              }
                            },
                            color: const Color(0xff1E91B6),
                            textColor: Colors.white,
                            borderRadius: 10.0,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 30.0),
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            height: 50,
                            width: 300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
    

      // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: HotelButton(
            //     text: "Next",
            //     onTap: () {
            //       if (_formKey.currentState!.validate()) {
            //         // Update provider with location data

            //         hotelProvider.updateHotelData('city', cityController.text);
            //         hotelProvider.updateHotelData(
            //             'state', stateController.text);
            //         hotelProvider.updateHotelData(
            //             'country', countryController.text);

            //         hotelProvider.updateHotelData(
            //             'pincode', int.parse(pincodeController.text));

            //         Navigator.of(context).push(MaterialPageRoute(
            //           builder: (context) => PoliciesPage(),
            //         ));
            //       }
            //     },
            //     color: const Color(0xff1E91B6),
            //     textColor: Colors.white,
            //     borderRadius: 10.0,
            //     padding: const EdgeInsets.symmetric(
            //         vertical: 15.0, horizontal: 30.0),
            //     fontSize: 16.0,
            //     fontWeight: FontWeight.bold,
            //     height: 50,
            //     width: 300,
            //   ),
            // ),