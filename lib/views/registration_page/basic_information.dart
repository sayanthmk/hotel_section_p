import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/field_information/hotel_provider.dart';
import 'package:hotel_side/views/registration_page/manual_location.dart';
import 'package:hotel_side/widgets/auth_widgets/textfrom_field.dart';
import 'package:hotel_side/widgets/home_page_widgets/button.dart';
import 'package:provider/provider.dart';

class BasicInformation extends StatelessWidget {
  final TextEditingController hotelNameController = TextEditingController();
  final TextEditingController bookingSinceController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  BasicInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<HotelProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xffF5F9FF),
      // appBar: AppBar(title: const Text('Hotel Information')),
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
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Basic information',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Hotel Name Field
                        CustomTextFormField(
                          controller: hotelNameController,
                          labelText: 'Stay/Hotel Name',
                          hintText: 'Enter your Hotel Name',
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Hotel Name is required';
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
                        //Booking Since
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Taking Booking Since',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        CustomTextFormField(
                          controller: bookingSinceController,
                          labelText: 'Booking Since',
                          hintText: 'Enter Booking Since',
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Booking Since is required';
                            } else if (value.length < 4 && value.length > 4) {
                              return 'Invalid Year';
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
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Contact Details',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        CustomTextFormField(
                          controller: contactNumberController,
                          labelText: 'Contact Number',
                          hintText: 'Enter your Contact Number',
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Contact Number is required';
                            } else if (value.length < 10) {
                              return 'Invalid phone number';
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
                          controller: emailAddressController,
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            } else if (!RegExp(
                                    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-z]{2,7}$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          borderColor: Colors.grey,
                          focusedBorderColor: Colors.blue,
                          enabledBorderColor: Colors.grey,
                          errorBorderColor: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: HotelButton(
                text: "Next",
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    hotelProvider.updateHotelData(
                        'hotel_name', hotelNameController.text);
                    hotelProvider.updateHotelData('Booking_since',
                        int.parse(bookingSinceController.text));
                    hotelProvider.updateHotelData(
                        'contact_number', contactNumberController.text);
                    hotelProvider.updateHotelData(
                        'email_address', emailAddressController.text);

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LocationAddByUser(),
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
    );
  }
}
