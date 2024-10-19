import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_side/constants/colors/colors.dart';
import 'package:hotel_side/views/auth/login.dart';
import 'package:hotel_side/views/auth/phone.dart';
import 'package:hotel_side/widgets/auth_widgets/bottom_text_row.dart';
import 'package:hotel_side/widgets/auth_widgets/divider.dart';
import 'package:hotel_side/widgets/auth_widgets/gradiant_button.dart';
import 'package:hotel_side/widgets/auth_widgets/textfrom_field.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_service/auth_service.dart';

class SignUpPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      // appBar: AppBar(title: Text('Sign Up')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFormField(
                    controller: emailController,
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
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: passwordController,
                    labelText: 'Password',
                    hintText: 'Enter your Password',
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    borderColor: Colors.grey,
                    focusedBorderColor: Colors.blue,
                    enabledBorderColor: Colors.grey,
                    errorBorderColor: Colors.red,
                    obscureText: true,
                    suffixIcon: const Icon(Icons.remove_red_eye),
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: confirmPasswordController,
                    labelText: 'Confirm Password',
                    hintText: 'Enter your Password',
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirmation password is required';
                      } else if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    borderColor: Colors.grey,
                    focusedBorderColor: Colors.blue,
                    enabledBorderColor: Colors.grey,
                    errorBorderColor: Colors.red,
                    obscureText: true,
                    suffixIcon: const Icon(Icons.remove_red_eye),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: "Sign Up",
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        log("validate createUserWithEmailAndPassword");
                        // final email = emailController.text.trim();
                        // final password = passwordController.text.trim();
                        await authService.createUserWithEmailAndPassword(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      }
                    },
                    color: AdminColors.primerybuttoncolor,
                    textColor: Colors.white,
                    borderRadius: 10.0,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 30.0),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    height: 50,
                    width: 300,
                    // gradient: AdminColors.primerybuttoncolor,
                  ),
                  const DividerWithText(
                    text: 'or',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.grey,
                    dividerColor: Colors.grey,
                    thickness: 2,
                    indent: 10,
                    endIndent: 10,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    text: "",
                    onTap: () async {
                      // context.read<AuthBloc>().add(SignInGoogleEvent());
                      await authService.signInWithGoogle();
                    },
                    color: Colors.white,
                    textColor: Colors.grey,
                    borderRadius: 10.0,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 30.0),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    height: 60,
                    width: 350,
                    icon: FontAwesomeIcons.google,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    text: "",
                    onTap: () {
                      // context.read<AuthBloc>().add(SignInGoogleEvent());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PhoneInputPage()),
                      );
                    },
                    color: Colors.white,
                    textColor: Colors.grey,
                    borderRadius: 10.0,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 30.0),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    height: 60,
                    width: 350,
                    icon: FontAwesomeIcons.phone,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SignInRow(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    signInText: 'Sign In',
                    promptText: 'Already have an account? ',
                    signInTextColor: Colors.blue,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
         // TextFormField(
                  //   controller: passwordController,
                  //   decoration: InputDecoration(labelText: 'Password'),
                  //   obscureText: true,
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter a password';
                  //     }
                  //     if (value.length < 6) {
                  //       return 'Password must be at least 6 characters long';
                  //     }
                  //     return null;
                  //   },
                  // ),
                          // TextFormField(
                  //   controller: _emailController,
                  //   decoration: InputDecoration(labelText: 'Email'),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter an email';
                  //     }
                  //     if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  //         .hasMatch(value)) {
                  //       return 'Please enter a valid email';
                  //     }
                  //     return null;
                  //   },
                  // ),
                            // TextFormField(
                  //   controller: confirmPasswordController,
                  //   decoration: InputDecoration(labelText: 'Confirm Password'),
                  //   obscureText: true,
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please confirm your password';
                  //     }
                  //     if (value != passwordController.text) {
                  //       return 'Passwords do not match';
                  //     }
                  //     return null;
                  //   },
                  // ),
                         // context.read<AuthBloc>().add(
                        //       SignUpEmailPasswordEvent(
                        //         email: email,
                        //         password: password,
                        //       ),
                        //     );
                                        // ElevatedButton(
                  //   child: Text('Sign Up'),
                  //   onPressed: () async {
                  //     if (formKey.currentState!.validate()) {
                  //       try {
                  //         await authService.createUserWithEmailAndPassword(
                  //           emailController.text,
                  //           passwordController.text,
                  //         );
                  //         Navigator.pop(
                  //             context); // Return to login page after successful sign-up
                  //       } catch (e) {
                  //         ScaffoldMessenger.of(context).showSnackBar(
                  //           SnackBar(
                  //               content: Text('Failed to sign up: ${e.toString()}')),
                  //         );
                  //       }
                  //     }
                  //   },
                  // ),