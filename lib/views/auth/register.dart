// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_side/constants/colors/colors.dart';
import 'package:hotel_side/views/auth/login_page/custom_log_button.dart';
import 'package:hotel_side/views/auth/login_page/login.dart';
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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue.shade50,
                  Colors.white,
                ],
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.02,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.04),
                        Text(
                          'Create Account',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Text(
                          'Please fill in the details to get started',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                        ),
                        SizedBox(height: size.height * 0.04),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 10,
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
                                prefixIcon: const Icon(Icons.email_outlined),
                                borderColor: Colors.grey.shade200,
                                focusedBorderColor: Colors.blue,
                                enabledBorderColor: Colors.grey.shade200,
                                errorBorderColor: Colors.red.shade300,
                              ),
                              const SizedBox(height: 16),
                              CustomTextFormField(
                                controller: passwordController,
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
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
                                prefixIcon: const Icon(Icons.lock_outline),
                                borderColor: Colors.grey.shade200,
                                focusedBorderColor: Colors.blue,
                                enabledBorderColor: Colors.grey.shade200,
                                errorBorderColor: Colors.red.shade300,
                                obscureText: true,
                                suffixIcon:
                                    const Icon(Icons.visibility_outlined),
                              ),
                              const SizedBox(height: 16),
                              CustomTextFormField(
                                controller: confirmPasswordController,
                                labelText: 'Confirm Password',
                                hintText: 'Confirm your password',
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Confirmation password is required';
                                  } else if (value != passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                                prefixIcon: const Icon(Icons.lock_outline),
                                borderColor: Colors.grey.shade200,
                                focusedBorderColor: Colors.blue,
                                enabledBorderColor: Colors.grey.shade200,
                                errorBorderColor: Colors.red.shade300,
                                obscureText: true,
                                suffixIcon:
                                    const Icon(Icons.visibility_outlined),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Center(
                          child: CustomButton(
                            text: "Create Account",
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                log("validate createUserWithEmailAndPassword");
                                await authService
                                    .createUserWithEmailAndPassword(
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                );
                              }
                            },
                            color: AdminColors.primerybuttoncolor,
                            textColor: Colors.white,
                            borderRadius: 12.0,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            height: 55,
                            width: size.width * 0.9,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const DividerWithText(
                          text: 'or continue with',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          textColor: Colors.grey,
                          dividerColor: Colors.grey,
                          thickness: 1,
                          indent: 20,
                          endIndent: 20,
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                            const SizedBox(width: 50),
                            CustomSocialButton(
                              icon: FontAwesomeIcons.phone,
                              color: Colors.blue,
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PhoneInputPage(),
                                  ),
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
                        Center(
                          child: SignInRow(
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
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
