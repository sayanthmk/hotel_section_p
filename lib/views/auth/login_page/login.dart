// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hotel_side/constants/colors/colors.dart';
import 'package:hotel_side/views/auth/check_reg_page/regcheckpage.dart';
import 'package:hotel_side/views/auth/login_page/custom_log_button.dart';
import 'package:hotel_side/views/auth/phone.dart';
import 'package:hotel_side/views/auth/register.dart';
import 'package:hotel_side/widgets/auth_widgets/bottom_text_row.dart';
import 'package:hotel_side/widgets/auth_widgets/divider.dart';
import 'package:hotel_side/widgets/auth_widgets/gradiant_button.dart';
import 'package:hotel_side/widgets/auth_widgets/textfrom_field.dart';
import 'package:provider/provider.dart';
import '../../../controllers/auth_service/auth_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height * 0.3,
                width: size.width * 1.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AdminColors.primerybuttoncolor,
                      AdminColors.primerybuttoncolor.withOpacity(0.8),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.hotel,
                      size: 70,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Sign in to continue',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          CustomTextFormField(
                            controller: emailController,
                            labelText: 'Email',
                            hintText: 'Enter your email',
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                            borderColor: Colors.grey.withOpacity(0.3),
                            focusedBorderColor: AdminColors.primerybuttoncolor,
                            enabledBorderColor: Colors.grey.withOpacity(0.3),
                            errorBorderColor: Colors.red.withOpacity(0.8),
                            prefixIcon: const Icon(Icons.email_outlined,
                                color: Colors.grey),
                          ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            controller: passwordController,
                            labelText: 'Password',
                            hintText: 'Enter your Password',
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            borderColor: Colors.grey.withOpacity(0.3),
                            focusedBorderColor: AdminColors.primerybuttoncolor,
                            enabledBorderColor: Colors.grey.withOpacity(0.3),
                            errorBorderColor: Colors.red.withOpacity(0.8),
                            obscureText: true,
                            prefixIcon: const Icon(Icons.lock_outline,
                                color: Colors.grey),
                            suffixIcon: const Icon(Icons.remove_red_eye,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: AdminColors.primerybuttoncolor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: "Login",
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            await authService.signInWithEmailAndPassword(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            );
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const HotelCheckPage(),
                            ));
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Failed to sign in: ${e.toString()}'),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        }
                      },
                      color: AdminColors.primerybuttoncolor,
                      textColor: Colors.white,
                      borderRadius: 25.0,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 30.0),
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      height: 55,
                      width: size.width * 0.85,
                    ),
                    const SizedBox(height: 25),
                    DividerWithText(
                      text: 'or continue with',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textColor: Colors.grey.shade600,
                      dividerColor: Colors.grey.shade300,
                      thickness: 1,
                      indent: 30,
                      endIndent: 30,
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomSocialButton(
                          icon: FontAwesomeIcons.google,
                          color: Colors.red,
                          onTap: () async {
                            await authService.signInWithGoogle();
                          },
                          size: 60,
                          iconSize: 24,
                          backgroundColor: Colors.white,
                          borderRadius: 15,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        CustomSocialButton(
                          icon: FontAwesomeIcons.phone,
                          color: Colors.blue,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PhoneInputPage()),
                            );
                          },
                          size: 60,
                          iconSize: 24,
                          backgroundColor: Colors.white,
                          borderRadius: 15,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    SignInRow(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      signInText: 'Sign Up',
                      promptText: "Don't have an account? ",
                      signInTextColor: AdminColors.primerybuttoncolor,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
