import 'package:flutter/material.dart';
import 'package:hotel_side/widgets/home_page_widgets/button.dart';

class SelectTheLocation extends StatelessWidget {
  const SelectTheLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F9FF),
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Color(0xff1E91B6),
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Enable Location',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'You need to enable loaction to\nbrowse stays near you',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Button at the Bottom
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  HotelButton(
                    text: "Allow Location",
                    onTap: () {},
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: () {}, child: const Text("Enter manually")),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
