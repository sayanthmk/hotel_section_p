import 'package:flutter/material.dart';
import 'package:hotel_side/views/registration_page/hotel_type/hotel_type_select.dart';
import 'package:hotel_side/widgets/home_page_widgets/button.dart';

class EntryRegistrationPage extends StatelessWidget {
  const EntryRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/hotel_gif.png'),
            const SizedBox(height: 20),
            const Text(
              'Yay!! We have registered your email with us you can start registration process,',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: HotelButton(
                text: "Start",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HotelTypeSelection(),
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
