import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/hotel_provider/hotel_provider.dart';
import 'package:hotel_side/views/registration_page/basic_info/form_section.dart';
import 'package:hotel_side/views/registration_page/location/manual_location.dart';
import 'package:hotel_side/widgets/home_page_widgets/button.dart';
import 'package:provider/provider.dart';

class BasicInformation extends StatelessWidget {
  final TextEditingController hotelNameController = TextEditingController();
  final TextEditingController bookingSinceController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController basePriceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  BasicInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<HotelProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xffF5F9FF),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xff1E91B6),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hotel Registration',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Please fill in your hotel\'s basic information',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            BasicInfoFormSection(
              formKey: _formKey,
              hotelNameController: hotelNameController,
              bookingSinceController: bookingSinceController,
              contactNumberController: contactNumberController,
              emailAddressController: emailAddressController,
              basePriceController: basePriceController,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: HotelButton(
                text: "Continue to Location Details",
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    hotelProvider.updateHotelData(
                        'hotel_name', hotelNameController.text);
                    hotelProvider.updateHotelData(
                        'Booking_since', bookingSinceController.text);
                    hotelProvider.updateHotelData(
                        'contact_number', contactNumberController.text);
                    hotelProvider.updateHotelData(
                        'email_address', emailAddressController.text);
                    hotelProvider.updateHotelData(
                        'property_setup', basePriceController.text);
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
                height: 55,
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
