import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/field_information/hotel_provider.dart';
import 'package:hotel_side/views/registration_page/finance_information.dart';
import 'package:hotel_side/widgets/home_page_widgets/button.dart';
import 'package:hotel_side/widgets/home_page_widgets/custom_checkbox.dart';
import 'package:provider/provider.dart';

class PoliciesPage extends StatelessWidget {
  const PoliciesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<HotelProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xffF5F9FF),
      // appBar: AppBar(title: const Text('Policies')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const Text(
                        'Select Policies you want to implement',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      // Policy 1 Checkbox

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CustomCheckbox(
                              value: hotelProvider.hotelData['free_cancel'] ??
                                  false,
                              onChanged: (value) {
                                hotelProvider.updateHotelData(
                                    'free_cancel', value);
                              },
                              activeColor: const Color(0xff1E91B6),
                              checkColor: Colors.white,
                              size: 25.0,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'Free Cancellation upto 24 hours.',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CustomCheckbox(
                              value:
                                  hotelProvider.hotelData['couple_friendly'] ??
                                      false,
                              onChanged: (value) {
                                hotelProvider.updateHotelData(
                                    'couple_friendly', value);
                              },
                              activeColor: const Color(0xff1E91B6),
                              checkColor: Colors.white,
                              size: 25.0,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'Couple Friendly',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CustomCheckbox(
                              value:
                                  hotelProvider.hotelData['parking_facility'] ??
                                      false,
                              onChanged: (value) {
                                hotelProvider.updateHotelData(
                                    'parking_facility', value);
                              },
                              activeColor: const Color(0xff1E91B6),
                              checkColor: Colors.white,
                              size: 25.0,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'Parking Facility',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CustomCheckbox(
                              value: hotelProvider
                                      .hotelData['restaurant_facility'] ??
                                  false,
                              onChanged: (value) {
                                hotelProvider.updateHotelData(
                                    'restaurant_facility', value);
                              },
                              activeColor: const Color(0xff1E91B6),
                              checkColor: Colors.white,
                              size: 25.0,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'Restaurant inside the property ',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: HotelButton(
                text: "Next",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FinanceInformation(),
                  ));
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
