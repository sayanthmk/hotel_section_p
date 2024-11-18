import 'package:flutter/material.dart';
import 'package:hotel_side/constants/colors/colors.dart';
import 'package:hotel_side/views/auth/login_page/login.dart';
import 'package:hotel_side/views/auth/register.dart';
import 'package:hotel_side/widgets/auth_widgets/gradiant_button.dart';

class AuthSelectionPage extends StatelessWidget {
  const AuthSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: "Login",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              color: AdminColors.primerybuttoncolor,
              textColor: Colors.white,
              borderRadius: 10.0,
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              height: 50,
              width: 300,
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              text: "Sign Up",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              color: AdminColors.primerybuttoncolor,
              textColor: Colors.white,
              borderRadius: 10.0,
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              height: 50,
              width: 300,
            ),
          ],
        ),
      ),
    );
  }
}
