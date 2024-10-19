import 'package:flutter/material.dart';
import 'package:hotel_side/constants/colors/colors.dart';
import 'package:hotel_side/views/auth/check_reg_page/regcheckpage.dart';
import 'package:hotel_side/views/auth/phone.dart';
import 'package:hotel_side/views/auth/register.dart';
import 'package:hotel_side/widgets/auth_widgets/bottom_text_row.dart';
import 'package:hotel_side/widgets/auth_widgets/divider.dart';
import 'package:hotel_side/widgets/auth_widgets/gradiant_button.dart';
import 'package:hotel_side/widgets/auth_widgets/textfrom_field.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_service/auth_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                  const SizedBox(
                    height: 30,
                  ),
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
                  const SizedBox(height: 30),
                  CustomButton(
                    text: "Login",
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          await authService.signInWithEmailAndPassword(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HotelCheckPage(),
                          ));
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('Failed to sign in: ${e.toString()}')),
                          );
                        }
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
                  const SizedBox(
                    height: 20,
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
                  const SizedBox(height: 16),
                  CustomButton(
                    text: "Continue With Google",
                    onTap: () async {
                      await authService.signInWithGoogle();
                    },
                    color: Colors.white,
                    textColor: Colors.red,
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
                    text: "Continue With Phone",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PhoneInputPage()),
                      );
                    },
                    color: Colors.white,
                    textColor: Colors.blue,
                    borderRadius: 10.0,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 30.0),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    height: 60,
                    width: 350,
                    icon: FontAwesomeIcons.phone,
                  ),
                  SignInRow(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    signInText: 'Sign Up',
                    promptText: 'Create a account? ',
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
                  //   controller: _emailController,
                  //   decoration: const InputDecoration(labelText: 'Email'),
                  //   validator: (value) => value!.isEmpty ? 'Enter an email' : null,
                  // ),
                           // TextFormField(
                  //   controller: passwordController,
                  //   decoration: const InputDecoration(labelText: 'Password'),
                  //   obscureText: true,
                  //   validator: (value) =>
                  //       value!.isEmpty ? 'Enter a password' : null,
                  // ),
                       // ElevatedButton(
                  //   child: const Text('Sign in with Email'),
                  //   onPressed: () async {
                  //     if (formKey.currentState!.validate()) {
                  //       try {
                  //         await authService.signInWithEmailAndPassword(
                  //           emailController.text,
                  //           passwordController.text,
                  //         );
                  //       } catch (e) {
                  //         ScaffoldMessenger.of(context).showSnackBar(
                  //           SnackBar(
                  //               content:
                  //                   Text('Failed to sign in: ${e.toString()}')),
                  //         );
                  //       }
                  //     }
                  //   },
                  // ),
                          // const SizedBox(height: 16),
                  // TextButton(
                  //   child: const Text('Create an account'),
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => SignUpPage()),
                  //     );
                  //   },
                  // ),
                                    // ElevatedButton(
                  //   child: const Text('Sign in with Google'),
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => const GoogleSignInPage()),
                  //     );
                  //   },
                  // ),
                  // const SizedBox(height: 16),
                  // ElevatedButton(
                  //   child: const Text('Sign in with Phone'),
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => PhoneInputPage()),
                  //     );
                  //   },
                  // ),
                       // Navigator.pop(context);
                      // context.read<AuthBloc>().add(SignInGoogleEvent());
                         // if (formKey.currentState!.validate()) {
                      //   await authService.signInWithEmailAndPassword(
                      //     emailController.text,
                      //     passwordController.text,
                      //   );
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => HomePage(),
                      //   ));
                      // }